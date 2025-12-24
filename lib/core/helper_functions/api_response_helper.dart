import 'package:dio/dio.dart';
import 'package:currency_converter/core/errors/exceptions.dart';

class ApiResponseHelper {
  static Map<String, dynamic>? _body(Response response) {
    return response.data is Map<String, dynamic>
        ? response.data as Map<String, dynamic>
        : null;
  }

  static bool isSuccess(Response response) {
    final int statusCode = response.statusCode ?? 0;
    final body = _body(response);

    final dynamic apiCode = body?['code'] ?? body?['status_code'] ?? body?['status'];
    final bool isCodeSuccess = apiCode is int && apiCode >= 200 && apiCode < 300;
    final bool isSuccessFlag = body?['success'] == true || body?['status'] == true;

    return (statusCode >= 200 && statusCode < 300) || isCodeSuccess || isSuccessFlag;
  }

  static String errorMessage(Response response, {String fallback = 'Request failed'}) {
    final body = _body(response);
    final String message = body?['message']?.toString() ?? fallback;
    return message;
  }

  static T requireSuccessThen<T>(Response response, T Function(Map<String, dynamic>? body) onSuccess) {
    if (isSuccess(response)) {
      return onSuccess(_body(response));
    }
    throw ServerException(errorMessage(response));
  }
}


