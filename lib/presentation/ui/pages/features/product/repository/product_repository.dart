import 'package:skinisense/domain/model/product.dart';
import 'package:skinisense/domain/provider/product_provider.dart';

class ProductRepository {
  final ProductProvider _productProvider;

  ProductRepository(this._productProvider);

  Future<List<Product>> fetchProducts() async {
    try {
      return await _productProvider.getProducts();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<Product> fetchProductById(String id) async {
    try {
      return await _productProvider.getProductById(id);
    } catch (e) {
      throw Exception('Failed to fetch product by ID: $e');
    }
  }
}
