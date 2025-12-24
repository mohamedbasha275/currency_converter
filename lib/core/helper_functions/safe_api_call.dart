import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:currency_converter/core/errors/failures.dart';
import 'package:currency_converter/core/errors/exceptions.dart';

Future<Either<Failure, T>> safeApiCall<T>(Future<T> Function() call) async {
  try {
    final result = await call();
    return Right(result);
  } catch (e) {
    print('Error Log :${e.toString()}');
    if (e is DioException) {
      return Left(ServerFailure.fromDioError(e));
    }
    if (e is AppException) {
      return Left(ServerFailure(e.message));
    }
    return Left(ServerFailure(e.toString()));
  }
}
