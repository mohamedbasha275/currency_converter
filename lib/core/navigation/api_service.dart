import 'dart:convert';
import 'package:currency_converter/core/navigation/end_points.dart';
import 'package:dio/dio.dart';

//================= flags =================//
const String flagSite = 'https://flagcdn.com/w80/';
//==================================//
const String _acceptHeader = 'application/json';
const String _apiToken = 'yTgM3dak5bNFUnLv4H0D5GUV54h4lWHh';

class ApiService {
  static const String _baseUrl = 'https://api.apilayer.com/exchangerates_data/';
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, String>> _buildHeaders({required bool isToken}) async {
    final headers = <String, String>{
      'Accept': _acceptHeader,
    };
    return headers;
  }


  Future<Map<String, dynamic>> _request({
    required String method,
    required Endpoint endpoint,
    dynamic data,
    bool isToken = true,
    String parameter = '',
  }) async {
    final headers = await _buildHeaders(isToken: isToken);
    final url = '$_baseUrl${endpoint.value}${'?apikey=$_apiToken'}${parameter.isNotEmpty ? parameter : ''}';
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
      final normalized = <String, dynamic>{'statusCode': response.statusCode};
      dynamic body = response.data;
      if (body is String) {
        try {
          body = jsonDecode(body);
        } catch (_) {
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