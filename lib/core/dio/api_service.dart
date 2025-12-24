import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:currency_converter/core/di/service_locator.dart';
import 'package:currency_converter/core/dio/end_points.dart';
import 'package:currency_converter/core/shared_preferences/app_prefs.dart';

const String _acceptHeader = 'application/json';

class ApiService {
  static const String _baseUrl = 'https://demo.qansah.com/api/';
  final Dio _dio;

  ApiService(this._dio);

  /// Build headers including token + language
  Future<Map<String, String>> _buildHeaders({required bool isToken}) async {
    final headers = <String, String>{
      'Accept': _acceptHeader,
      'Accept-Language': await _getLanguageCode(),
    };

    final token = await _getAuthorizationToken(isToken: isToken);
    if (token.isNotEmpty) {
      headers['Authorization'] = token;
    }
    headers['X-API-Secret-Key'] = 'your_strong_secret_key_here';
    return headers;
  }

  Future<String> _getAuthorizationToken({required bool isToken}) async {
    if (!isToken) return '';
    final String backendToken = getIt.get<AppPreferences>().getAuthToken();
    if (backendToken.isEmpty) return '';
    return 'Bearer $backendToken';
  }

  Future<String> _getLanguageCode() async {
    final appPreferences = getIt.get<AppPreferences>();
    return appPreferences.getLanguageCode();
  }

  /// Generic handler for all HTTP methods
  Future<Map<String, dynamic>> _request({
    required String method,
    required Endpoint endpoint,
    dynamic data,
    bool isToken = true,
    String parameter = '',
  }) async {
    final headers = await _buildHeaders(isToken: isToken);
    final url = '$_baseUrl${endpoint.value}${parameter.isNotEmpty ? parameter : ''}';
    final options = Options(headers: headers);

    late Response response;

    try {
      // ----------- Send request -----------
      switch (method.toUpperCase()) {
        case 'GET':
          response = await _dio.get(url, options: options);
          break;
        case 'POST':
          response = await _dio.post(url, data: data, options: options);
          break;
        case 'DELETE':
          response = await _dio.delete(url, options: options);
          break;
        case 'PUT':
          response = await _dio.put(url, data: data, options: options);
          break;
        default:
          throw UnsupportedError('HTTP method $method is not supported');
      }

      // ----------- Normalize response -----------
      final normalized = <String, dynamic>{
        'statusCode': response.statusCode,
      };

      dynamic body = response.data;

      // If backend returned JSON string → decode it
      if (body is String) {
        try {
          body = jsonDecode(body);
        } catch (_) {
          // if not json → keep as string
          body = body;
        }
      }

      if (body is Map<String, dynamic>) {
        normalized.addAll(body);
      } else {
        normalized['data'] = body;
      }

      return normalized;
    } on DioException {
      // Re-throw to upstream
      rethrow;
    }
  }

  // ---------------- Public methods ----------------

  Future<Map<String, dynamic>> get({
    required Endpoint endpoint,
    bool isToken = true,
    String parameter = '',
  }) async {
    return await _request(
      method: 'GET',
      endpoint: endpoint,
      isToken: isToken,
      parameter: parameter,
    );
  }

  Future<Map<String, dynamic>> post({
    required Endpoint endpoint,
    dynamic data,
    bool isToken = true,
    String parameter = '',
  }) async {
    return await _request(
      method: 'POST',
      endpoint: endpoint,
      data: data,
      isToken: isToken,
      parameter: parameter,
    );
  }

  Future<Map<String, dynamic>> postWithImages({
    required Endpoint endpoint,
    required dynamic data,
    bool isToken = true,
    String parameter = '',
  }) async {
    return await _request(
      method: 'POST',
      endpoint: endpoint,
      data: data,
      isToken: isToken,
      parameter: parameter,
    );
  }

  Future<Map<String, dynamic>> delete({
    required Endpoint endpoint,
    bool isToken = true,
    String parameter = '',
  }) async {
    return await _request(
      method: 'DELETE',
      endpoint: endpoint,
      isToken: isToken,
      parameter: parameter,
    );
  }

  Future<Map<String, dynamic>> put({
    required Endpoint endpoint,
    dynamic data,
    bool isToken = true,
    String parameter = '',
  }) async {
    return await _request(
      method: 'PUT',
      endpoint: endpoint,
      data: data,
      isToken: isToken,
      parameter: parameter,
    );
  }
}






// import 'package:dio/dio.dart';
// import 'package:currency_converter/core/di/service_locator.dart';
// import 'package:currency_converter/core/dio/end_points.dart';
// import 'package:currency_converter/core/shared_preferences/app_prefs.dart';
//
// const String _acceptHeader = 'application/json';
//
// class ApiService {
//   //static const String _baseUrl = 'https://api.qansah.com/v1/';
//   static const String _baseUrl = 'https://demo.qansah.com/api/';
//   final Dio _dio;
//
//   ApiService(this._dio);
//
//   /// Builds headers for each request, including authorization and language.
//   Future<Map<String, String>> _buildHeaders({required bool isToken}) async {
//     final headers = <String, String>{
//       'Accept': _acceptHeader,
//       'Accept-Language': await _getLanguageCode(),
//     };
//
//     final token = await _getAuthorizationToken(isToken: isToken);
//     if (token.isNotEmpty) {
//       headers['Authorization'] = token;
//     }
//     return headers;
//   }
//
//   Future<String> _getAuthorizationToken({required bool isToken}) async {
//     if (!isToken) return '';
//     final String backendToken = getIt.get<AppPreferences>().getAuthToken();
//     if (backendToken.isEmpty) return '';
//     return 'Bearer $backendToken';
//   }
//
//   Future<String> _getLanguageCode() async {
//     final appPreferences = getIt.get<AppPreferences>();
//     return appPreferences.getLanguageCode();
//   }
//
//   /// Generic request handler for all HTTP methods.
//   Future<Map<String, dynamic>> _request({
//     required String method,
//     required Endpoint endpoint,
//     dynamic data,
//     bool isToken = true,
//     String parameter = '',
//   }) async {
//     final headers = await _buildHeaders(isToken: isToken);
//     final url = '$_baseUrl${endpoint.value}${parameter.isNotEmpty ? '$parameter' : ''}';
//     final options = Options(headers: headers);
//
//     late Response response;
//
//     try {
//       switch (method.toUpperCase()) {
//         case 'GET':
//           response = await _dio.get(url, options: options);
//           break;
//         case 'POST':
//           response = await _dio.post(url, data: data, options: options);
//           break;
//         case 'DELETE':
//           response = await _dio.delete(url, options: options);
//           break;
//         case 'PUT':
//           response = await _dio.put(url, data: data, options: options);
//           break;
//         default:
//           throw UnsupportedError('HTTP method $method is not supported');
//       }
//       final responseData = <String, dynamic>{
//         'statusCode': response.statusCode,
//       };
//
//       if (response.data is Map<String, dynamic>) {
//         responseData.addAll(response.data as Map<String, dynamic>);
//       } else if (response.data is String) {
//         // Optionally handle string responses (e.g., empty body)
//         responseData['data'] = response.data;
//       } else {
//         // Fallback for other types
//         responseData['data'] = response.data;
//       }
//
//       return responseData;
//     } on DioException catch (e) {
//       // Re-throw DioException so upstream safeApiCall can parse and map
//       // a clear, user-friendly message via ServerFailure.fromDioError
//       throw e;
//     }
//   }
//
//   Future<Map<String, dynamic>> get({
//     required Endpoint endpoint,
//     bool isToken = true,
//     String parameter = '',
//   }) async {
//     return await _request(
//       method: 'GET',
//       endpoint: endpoint,
//       isToken: isToken,
//       parameter: parameter,
//     );
//   }
//
//   Future<Map<String, dynamic>> post({
//     required Endpoint endpoint,
//     dynamic data,
//     bool isToken = true,
//     String parameter = '',
//   }) async {
//     return await _request(
//       method: 'POST',
//       endpoint: endpoint,
//       data: data,
//       isToken: isToken,
//       parameter: parameter,
//     );
//   }
//
//   Future<Map<String, dynamic>> postWithImages({
//     required Endpoint endpoint,
//     required dynamic data,
//     bool isToken = true,
//     String parameter = '',
//   }) async {
//     return await _request(
//       method: 'POST',
//       endpoint: endpoint,
//       data: data,
//       isToken: isToken,
//       parameter: parameter,
//     );
//   }
//
//   Future<Map<String, dynamic>> delete({
//     required Endpoint endpoint,
//     bool isToken = true,
//     String parameter = '',
//   }) async {
//     return await _request(
//       method: 'DELETE',
//       endpoint: endpoint,
//       isToken: isToken,
//       parameter: parameter,
//     );
//   }
//
//   Future<Map<String, dynamic>> put({
//     required Endpoint endpoint,
//     dynamic data,
//     bool isToken = true,
//     String parameter = '',
//   }) async {
//     return await _request(
//       method: 'PUT',
//       endpoint: endpoint,
//       data: data,
//       isToken: isToken,
//       parameter: parameter,
//     );
//   }
// }