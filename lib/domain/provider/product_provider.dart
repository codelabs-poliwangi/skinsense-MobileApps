import 'dart:convert';
import 'package:skinisense/config/api/api.dart';
import 'package:skinisense/domain/model/product.dart';
import 'package:skinisense/domain/services/api_client.dart';
import 'package:skinisense/domain/utils/logger.dart';

class ProductProvider {
  final ApiClient apiClient;
  ProductProvider(this.apiClient);
  Future<List<Product>> getProducts() async {
    try {
      final response = await apiClient.get("$productUrl", requireAuth: true);

      if (response.statusCode == 200) {
        logger.i('Data product: ${response.data}');

        // Pastikan response.data adalah List<dynamic>
        final products = (response.data as List<dynamic>)
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();

        logger.d('Successfully fetched ${products.length} products with limit');
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<List<Product>> getProductWithLimit(int limit) async {
    try {
      final response =
          await apiClient.get("$productUrl?limit=$limit", requireAuth: true);

      if (response.statusCode == 200) {
        logger.i('Data product: ${response.data}');

        // Pastikan response.data adalah List<dynamic>
        final products = (response.data as List<dynamic>)
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();

        logger.d(
            'Successfully fetched ${products.length} products with limit $limit');
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<List<Product>> getProductbyName(String name) async {
    try {
      final response =
          await apiClient.get("$productUrl?search=$name", requireAuth: true);
      if (response.statusCode == 200) {
        // Pastikan response.data adalah List<dynamic>
        final products = (response.data as List<dynamic>)
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
        if (products.isEmpty) {
          logger.d('there is no product with name $name');
          // Jika produk tidak ditemukan, bisa lempar exception atau kembalikan daftar kosong
          throw Exception('No products found');
        }
        logger.d(
            'Successfully fetched ${products.length} products with name $name');
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<List<Product>> getProductbyPage(int page) async {
    try {
      final response =
          await apiClient.get("$productUrl?page=$page", requireAuth: true);
      if (response.statusCode == 200) {
        final products = (response.data as List<dynamic>)
            .map((json) => Product.fromJson(json as Map<String, dynamic>))
            .toList();
        logger.d(
            'Successfully fetched ${products.length} products with page $page');
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
