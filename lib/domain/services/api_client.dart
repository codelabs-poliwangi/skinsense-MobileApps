// lib/core/network/api_client.dart
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:skinisense/config/api/api.dart';
import 'package:skinisense/domain/services/token-service.dart';

class ApiResponse<T> {
  final T data;
  final T message;
  final int statusCode;
  final Map<String, String> headers;

  ApiResponse({
    required this.data,
    required this.statusCode,
    required this.message,
    required this.headers,
  });
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => message;
}
class ApiClient {
  final Duration timeout;
  final TokenService tokenService;
  
  ApiClient(this.tokenService, { 
    this.timeout = const Duration(seconds: 30),
  });

  Future<Map<String, String>> _getHeaders({bool requireAuth = true}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (requireAuth) {
      final token = await tokenService.getAccessToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool requireAuth = true,
  }) async {
    try {
      final uri = Uri.parse(path).replace(
        queryParameters: queryParameters,
      );

      final defaultHeaders = await _getHeaders(requireAuth: requireAuth);
      final response = await http
          .get(
            uri,
            headers: {...defaultHeaders, ...?headers},
          )
          .timeout(timeout);

      return _handleResponse<T>(response);
    } on TimeoutException {
      throw ApiException(message: 'Request timeout');
    } catch (e) {
      throw ApiException(message: 'Network error: $e');
    }
  }

  Future<ApiResponse<T>> post<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool requireAuth = true,
  }) async {
    try {
      final uri = Uri.parse(path).replace(
        queryParameters: queryParameters,
      );

      final defaultHeaders = await _getHeaders(requireAuth: requireAuth);
      final response = await http
          .post(
            uri,
            headers: {...defaultHeaders, ...?headers},
            body: data != null ? json.encode(data) : null,
          )
          .timeout(timeout);

      return _handleResponse<T>(response);
    } on TimeoutException {
      throw ApiException(message: 'Request timeout');
    } catch (e) {
      throw ApiException(message: 'Network error: $e');
    }
  }

  Future<ApiResponse<T>> put<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool requireAuth = true,
  }) async {
    try {
      final uri = Uri.parse(path).replace(
        queryParameters: queryParameters,
      );

      final defaultHeaders = await _getHeaders(requireAuth: requireAuth);
      final response = await http
          .put(
            uri,
            headers: {...defaultHeaders, ...?headers},
            body: data != null ? json.encode(data) : null,
          )
          .timeout(timeout);

      return _handleResponse<T>(response);
    } on TimeoutException {
      throw ApiException(message: 'Request timeout');
    } catch (e) {
      throw ApiException(message: 'Network error: $e');
    }
  }

  Future<ApiResponse<T>> delete<T>(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
    bool requireAuth = true,
  }) async {
    try {
      final uri = Uri.parse(path).replace(
        queryParameters: queryParameters,
      );

      final defaultHeaders = await _getHeaders(requireAuth: requireAuth);
      final response = await http
          .delete(
            uri,
            headers: {...defaultHeaders, ...?headers},
          )
          .timeout(timeout);

      return _handleResponse<T>(response);
    } on TimeoutException {
      throw ApiException(message: 'Request timeout');
    } catch (e) {
      throw ApiException(message: 'Network error: $e');
    }
  }

  ApiResponse<T> _handleResponse<T>(http.Response response) {
    final body = response.body.isNotEmpty ? json.decode(response.body) : null;

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return ApiResponse<T>(
        headers: response.headers,
        statusCode: response.statusCode,
        message: body?['message'] ?? '',
        data: body?['data'] ?? body,
      );
    }

    switch (response.statusCode) {
      case 400:
        throw ApiException(
          message: body?['message'] ?? 'Bad request',
          statusCode: response.statusCode,
          data: body,
        );
      case 401:
        throw ApiException(
          message: body?['message'] ?? 'Unauthorized',
          statusCode: response.statusCode,
          data: body,
        );
      case 403:
        throw ApiException(
          message: body?['message'] ?? 'Forbidden',
          statusCode: response.statusCode,
          data: body,
        );
      case 404:
        throw ApiException(
          message: body?['message'] ?? 'Not found',
          statusCode: response.statusCode,
          data: body,
        );
      case 500:
        throw ApiException(
          message: body?['message'] ?? 'Internal server error',
          statusCode: response.statusCode,
          data: body,
        );
      default:
        throw ApiException(
          message: body?['message'] ?? 'Unknown error occurred',
          statusCode: response.statusCode,
          data: body,
        );
    }
  }
}
