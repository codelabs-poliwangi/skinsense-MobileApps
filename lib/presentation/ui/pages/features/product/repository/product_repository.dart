import 'package:skinisense/domain/model/product.dart';
import 'package:skinisense/domain/provider/product_provider.dart';
import 'package:skinisense/domain/utils/logger.dart';

class ProductRepository {
  final ProductProvider _productProvider;

  ProductRepository(this._productProvider);

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _productProvider.getProductWithLimit(100);
      logger.d('succes fecthing products from repository $response');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
  Future<List<Product>> fetchProductsByName(String query)async{
    try {
       final response = await _productProvider.getProductbyName(query);
      logger.d('succes searhing products by query $query');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  // Future<Product> fetchProductById(String id) async {
  //   try {
  //     return await _productProvider.getProductById(id);
  //   } catch (e) {
  //     throw Exception('Failed to fetch product by ID: $e');
  //   }
  // }
}
