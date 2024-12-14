import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:skinisense/domain/model/products.dart';
import 'package:skinisense/domain/utils/logger.dart';
import 'package:skinisense/presentation/ui/pages/features/product/repository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  int currentPage = 1;
  int totalPages = 0;
  List<Datum> allProducts = [];
  bool _hasReachedMax = false;

  ProductBloc(this._productRepository) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<SearchProduct>(_onSearchProduct);
  }

  Future<void> _onFetchProducts(
      FetchProducts event, Emitter<ProductState> emit) async {
    try {
      if (state is ProductInitial) {
        currentPage = 1;
        _hasReachedMax = false;
        allProducts.clear();

        emit(ProductLoading());

        final products = await _productRepository.fetchProducts(currentPage);

        currentPage = products.meta.page;
        totalPages = products.meta.pageCount;
        _hasReachedMax = currentPage >= totalPages;

        allProducts.addAll(products.data);

        logger.d(
            'Initial Fetch - Page: $currentPage, Total Pages: $totalPages, Products: ${allProducts.length}');

        emit(ProductLoaded(
          products: Products(
              statusCode: products.statusCode,
              message: products.message,
              data: allProducts,
              meta: products.meta),
          hasReachedMax: _hasReachedMax,
        ));
      } else if (state is ProductLoaded) {
        final currentState = state as ProductLoaded;

        // Jika sudah mencapai halaman terakhir, hentikan
        if (_hasReachedMax) {
          logger.d('Already reached max pages');
          return;
        }

        // Increment halaman
        currentPage++;

        final newProducts = await _productRepository.fetchProducts(currentPage);

        // Update status halaman terakhir
        totalPages = newProducts.meta.pageCount;
        _hasReachedMax = currentPage >= totalPages;

        // Tambahkan produk baru yang belum ada
        final uniqueNewProducts = newProducts.data
            .where((newProduct) => !allProducts
                .any((existingProduct) => existingProduct.id == newProduct.id))
            .toList();

        allProducts.addAll(uniqueNewProducts);

        logger.d(
            'Fetch More - Page: $currentPage, Total Pages: $totalPages, New Total Products: ${allProducts.length}');

        emit(ProductLoaded(
            products: Products(
                statusCode: newProducts.statusCode,
                message: newProducts.message,
                data: allProducts,
                meta: newProducts.meta),
            hasReachedMax: _hasReachedMax));
      }
    } catch (e) {
      logger.e('Error fetching products: $e');

      // Kembalikan ke halaman sebelumnya jika gagal
      if (currentPage > 1) {
        currentPage--;
      }

      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onSearchProduct(
      SearchProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    allProducts.clear(); // Bersihkan produk sebelumnya saat mencari

    try {
      final products =
          await _productRepository.fetchProductsByName(event.query);

      if (products.data.isEmpty) {
        emit(ProductNotFound(
            'Maaf, Product yang anda cari tidak ada, mungkin bisa mencari produk lainnya'));
      } else {
        allProducts.addAll(products.data);

        emit(ProductLoaded(
            products: products,
            hasReachedMax: true // Pencarian biasanya tidak di-scroll
            ));
      }
    } catch (e) {
      emit(ProductNotFound(
          'Maaf, Product yang anda cari tidak ada, mungkin bisa mencari produk lainnya'));
    }
  }
}
