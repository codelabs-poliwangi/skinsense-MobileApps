import 'package:skinisense/domain/model/product.dart';
import 'package:skinisense/domain/provider/product_provider.dart';
import 'package:skinisense/domain/utils/logger.dart';

class ProductRepository {
  final ProductProvider _productProvider;

  ProductRepository(this._productProvider);

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _productProvider.getProductWithLimit(40);
      logger.d('succes fecthing products from repository $response');
      return response;
      // return await _productProvider.getProductWithLimit(40);
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }
}
