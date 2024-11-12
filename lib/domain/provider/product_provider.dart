import 'dart:convert';
import 'package:skinisense/config/api/api.dart';
import 'package:skinisense/domain/model/product.dart';
import 'package:skinisense/domain/services/api_client.dart';

class ProductProvider {
  final ApiClient apiClient;
  ProductProvider(this.apiClient);

  Future<List<Product>> getProducts() async {
    try {
      final response = await apiClient.get(productUrl);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.data);
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  Future<Product> getProductById(String id) async {
    try {
      final response = await apiClient.get('$productUrl/$id');

      if (response.statusCode == 200) {
        return Product.fromJson(jsonDecode(response.data));
      } else {
        throw Exception('Failed to load product');
      }
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }
}
