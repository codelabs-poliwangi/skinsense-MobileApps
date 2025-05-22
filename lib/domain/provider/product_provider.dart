import 'dart:convert';
import 'package:skinisense/config/api/api.dart';
import 'package:skinisense/domain/model/products.dart';
import 'package:skinisense/domain/services/api_client.dart';
import 'package:skinisense/domain/utils/logger.dart';

class ProductProvider {
  final ApiClient apiClient;
  ProductProvider(this.apiClient);
  Future<Products> getProducts() async {
    try {
      final response = await apiClient.get(productUrl, requireAuth: true);

      if (response.statusCode == 200) {
        logger.i('Data product: $response');

        // Pastikan response.data adalah List<dynamic>
        // Parse response sesuai struktur Products
        // final products = Products.fromJson(response.data);
        final products = Products(
          statusCode: response.statusCode,
          message: response.message,
          data: (response.data as List<dynamic>)
              .map((json) => Datum.fromJson(json as Map<String, dynamic>))
              .toList(),
          meta: _extractMetaFromResponse(response)
              as Meta, // Atau buat Meta default jika diperlukan
        );

        logger.d('Successfully fetched $products');
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<Products> getProductWithLimit(int limit) async {
    try {
      final response =
          await apiClient.get("$productUrl?limit=$limit", requireAuth: true);

      if (response.statusCode == 200) {
        logger.i('Data product: ${response.data.length}');

        // Pastikan response.data adalah List<dynamic>
        // Parse response sesuai struktur Products
        // final products = Products.fromJson(response.data);
        final products = Products(
          statusCode: response.statusCode,
          message: response.message,
          data: (response.data as List<dynamic>)
              .map((json) => Datum.fromJson(json as Map<String, dynamic>))
              .toList(),
          meta: _extractMetaFromResponse(response)
              as Meta, // Atau buat Meta default jika diperlukan
        );

        logger.d('Successfully fetched $products');
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<Products> getProductbyName(String name) async {
    try {
      final response =
          await apiClient.get("$productUrl?search=$name", requireAuth: true);

      if (response.statusCode == 200) {
        // Parse response sesuai struktur Products
        final products = Products(
          statusCode: response.statusCode,
          message: response.message,
          data: (response.data as List<dynamic>)
              .map((json) => Datum.fromJson(json as Map<String, dynamic>))
              .toList(),
          meta: _extractMetaFromResponse(response)
              as Meta, // Atau buat Meta default jika diperlukan
        );

        logger.d('Successfully fetched $products');
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<Products> getProductbyPage(int page) async {
    try {
      final response =
          await apiClient.get("$productUrl?page=$page", requireAuth: true);

      if (response.statusCode == 200) {
        // Parse response sesuai struktur Products
        final products = Products(
          statusCode: response.statusCode,
          message: response.message,
          data: (response.data as List<dynamic>)
              .map((json) => Datum.fromJson(json as Map<String, dynamic>))
              .toList(),
          meta: _extractMetaFromResponse(response)
              as Meta, // Atau buat Meta default jika diperlukan
        );

        logger.d('Successfully fetched $products');
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  // Metode pembantu untuk ekstraksi Meta
  Meta? _extractMetaFromResponse(ApiResponse response) {
    try {
      // Coba ekstrak metadata dari berbagai sumber
      if (response.metadata is Map<String, dynamic>) {
        return Meta.fromJson(response.metadata);
      } else if (response.headers.containsKey('x-pagination')) {
        // Contoh jika metadata ada di header
        final paginationHeader = json.decode(response.headers['x-pagination']!);
        return Meta.fromJson(paginationHeader);
      }

      // Jika tidak ada metadata, kembalikan null atau buat default
      return Meta(
        page: 1,
        limit: response.data.length,
        productsCount: response.data.length,
        pageCount: 1,
        hasPreviousPage: false,
        hasNextPage: false,
      );
    } catch (e) {
      logger.e('Error extracting metadata: $e');
      return null;
    }
  }
}
