import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skinisense/domain/model/products.dart';
import 'package:skinisense/domain/utils/logger.dart';
import 'package:skinisense/presentation/ui/pages/features/home/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;

  ProductBloc(this._productRepository) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductInitial());
      try {
        emit(ProductLoading());
        final products = await _productRepository.fetchProducts();
        logger.d('Product Bloc : Fetched products: $products');
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
