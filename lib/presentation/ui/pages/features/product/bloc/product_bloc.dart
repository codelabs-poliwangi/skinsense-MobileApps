import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skinisense/domain/model/product.dart';
import 'package:skinisense/domain/utils/logger.dart';
import 'package:skinisense/presentation/ui/pages/features/product/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  ProductBloc(this._productRepository) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await _productRepository.fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    on<SearchProduct>((event, emit) async {
      emit(ProductLoading());
      try {
        final products =
            await _productRepository.fetchProductsByName(event.query);
        logger.d('hasil pencarian bloc : $products');
        if (products.isEmpty) {
          // Jika produk kosong, bisa beri response khusus
          emit(ProductNotFound('Maaf, Product yang anda cari tidak ada, mungkin bisa mencari produk lainnya'));
        } else {
          emit(ProductLoaded(products));
        }
      } catch (e) {
        emit(ProductNotFound('Maaf, Product yang anda cari tidak ada, mungkin bisa mencari produk lainnya'));
      }
    });
  }
}
