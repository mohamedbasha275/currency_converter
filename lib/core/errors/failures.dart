import 'package:dio/dio.dart';

/// Base class for all failures.
abstract class Failure {
  final String message;
  const Failure(this.message);
}

/// Represents a failure that occurred during a server/API call.
class ServerFailure extends Failure {
  const ServerFailure(super.message);

  static const Map<DioExceptionType, String> _dioErrorMessages = {
    DioExceptionType.connectionTimeout: 'Connection timeout. Please check your internet.',
    DioExceptionType.sendTimeout: 'Send timeout. Please check your internet.',
    DioExceptionType.receiveTimeout: 'Receive timeout. Please check your internet.',
    DioExceptionType.cancel: 'Request was canceled.',
    DioExceptionType.connectionError: 'No internet connection. Please check your network.',
  };

  static const Map<int, String> _statusErrorMessages = {
    400: 'Error occurred. Please try again.',
    401: 'Unauthorized access.',
    403: 'Forbidden access.',
    404: 'Your request was not found. Please try again later.',
    500: 'Internal server error. Please try again later.',
  };

  /// Creates a [ServerFailure] from a [DioException].
  factory ServerFailure.fromDioError(DioException dioError) {
    // Handle known Dio error types
    if (_dioErrorMessages.containsKey(dioError.type)) {
      return ServerFailure(_dioErrorMessages[dioError.type]!);
    }

    // Handle HTTP response errors
    if (dioError.type == DioExceptionType.badResponse) {
      final response = dioError.response;
      final statusCode = response?.statusCode ?? 0;
      return ServerFailure.fromResponse(statusCode, response?.data);
    }

    // Handle connection errors (SocketException, DNS lookup failures, etc.)
    if (dioError.type == DioExceptionType.unknown || 
        dioError.type == DioExceptionType.connectionError) {
      final errorMessage = dioError.error?.toString() ?? '';
      if (errorMessage.contains('SocketException') ||
          errorMessage.contains('Failed host lookup') ||
          errorMessage.contains('Network is unreachable')) {
        return const ServerFailure('No internet connection. Please check your network.');
      }
    }

    // Fallback for unexpected errors
    return const ServerFailure('Unexpected error. Please try again later.');
  }

  /// Creates a [ServerFailure] from an HTTP response.
  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (response is Map<String, dynamic>) {
      // Handle validation errors with nested messages
      final data = response['data'];
      if (data is Map<String, dynamic>) {
        for (final value in data.values) {
          if (value is List && value.isNotEmpty) {
            return ServerFailure(value.first.toString());
          }
        }
      }
      // Fallback to main message if present
      final message = response['message'];
      if (message != null && message.toString().isNotEmpty) {
        return ServerFailure(message.toString());
      }
    }

    // Handle known status code errors
    if (_statusErrorMessages.containsKey(statusCode)) {
      return ServerFailure(_statusErrorMessages[statusCode]!);
    }

    // Fallback for unknown errors
    return const ServerFailure('Something went wrong. Please try again later.');
  }
}

/// Represents a failure that occurred during local operations (cache, storage, etc.).
class LocalFailure extends Failure {
  const LocalFailure(super.message);
}

/// Represents a failure that occurred during cache operations.
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
