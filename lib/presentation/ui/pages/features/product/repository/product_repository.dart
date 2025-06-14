import 'package:skinisense/domain/model/products.dart';
import 'package:skinisense/domain/provider/product_provider.dart';
import 'package:skinisense/domain/utils/logger.dart';

class ProductRepository {
  final ProductProvider _productProvider;

  ProductRepository(this._productProvider);

  Future<Products> fetchProducts(int page) async {
    try {
      final response = await _productProvider.getProductbyPage(page);
      logger.d('succes fecthing products from repository $response');
      return response;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
  Future<Products> fetchProductsByName(String query)async{
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
