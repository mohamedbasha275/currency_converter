import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:currency_converter/core/errors/failures.dart';

/// Utility class for making safe API calls with proper error handling.
class SafeCallApi {
  /// Executes an API call and returns either a Failure or the result.
  /// 
  /// [apiCall] - The API function to execute
  /// Returns [Either<Failure, T>] - Either a failure or the expected result
  static Future<Either<Failure, T>> call<T>(
    Future<T> Function() apiCall,
  ) async {
    try {
      final result = await apiCall();
      return Right(result);
    } on DioException catch (dioError) {
      return Left(ServerFailure.fromDioError(dioError));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  /// Executes an API call that returns Map<String, dynamic> and extracts data field.
  /// 
  /// [apiCall] - The API function that returns Map<String, dynamic>
  /// [dataKey] - The key to extract from the response (defaults to 'data')
  /// Returns [Either<Failure, T>] - Either a failure or the extracted data
  static Future<Either<Failure, T>> callAndExtractData<T>(
    Future<Map<String, dynamic>> Function() apiCall, {
    String dataKey = 'data',
    required T Function(dynamic data) fromJson,
  }) async {
    try {
      final response = await apiCall();
      
      if (!response.containsKey(dataKey)) {
        return Left(ServerFailure('Invalid response format: missing $dataKey field'));
      }
      
      final extractedData = response[dataKey];
      final result = fromJson(extractedData);
      return Right(result);
    } on DioException catch (dioError) {
      return Left(ServerFailure.fromDioError(dioError));
    } catch (e) {
      return Left(ServerFailure('Error processing response: ${e.toString()}'));
    }
  }

  /// Executes an API call for list responses and extracts data field.
  /// 
  /// [apiCall] - The API function that returns Map<String, dynamic>
  /// [dataKey] - The key to extract from the response (defaults to 'data')
  /// Returns [Either<Failure, List<T>>] - Either a failure or the extracted list
  static Future<Either<Failure, List<T>>> callAndExtractList<T>(
    Future<Map<String, dynamic>> Function() apiCall, {
    String dataKey = 'data',
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await apiCall();
      
      if (!response.containsKey(dataKey)) {
        return Left(ServerFailure('Invalid response format: missing $dataKey field'));
      }
      
      final extractedData = response[dataKey];
      if (extractedData is! List) {
        return Left(ServerFailure('Invalid response format: $dataKey is not a list'));
      }
      
      final List<T> result = extractedData
          .map<T>((item) => fromJson(item as Map<String, dynamic>))
          .toList();
      
      return Right(result);
    } on DioException catch (dioError) {
      return Left(ServerFailure.fromDioError(dioError));
    } catch (e) {
      return Left(ServerFailure('Error processing response: ${e.toString()}'));
    }
  }
}
