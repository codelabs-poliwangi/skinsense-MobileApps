  // sliver: SliverGrid.builder(
  //                     gridDelegate:
  //                         const SliverGridDelegateWithFixedCrossAxisCount(
  //                       crossAxisCount: 2,
  //                       crossAxisSpacing: 8,
  //                       mainAxisSpacing: 8,
  //                       childAspectRatio: 0.69,
  //                     ),
  //                     addAutomaticKeepAlives: true,
  //                     addRepaintBoundaries: true,
  //                     addSemanticIndexes: true,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       // Check if we're at the last index and haven't reached max
  //                       if (index < state.products.data.length) {
  //                         return GestureDetector(
  //                           onTap: () {
  //                             Navigator.push(context, MaterialPageRoute(
  //                               builder: (context) {
  //                                 return ProductDetailPage(
  //                                   id: state.products.data[index].id,
  //                                   name: state.products.data[index].name,
  //                                   price: state.products.data[index].price,
  //                                   rating:
  //                                       state.products.data[index].rating ?? 0,
  //                                   shop: state.products.data[index].shop,
  //                                   image: state.products.data[index].image,
  //                                   sold: state.products.data[index].sold,
  //                                   linkProduct:
  //                                       state.products.data[index].linkProduct,
  //                                   category:
  //                                       state.products.data[index].category,
  //                                 );
  //                               },
  //                             ));
  //                           },
  //                           child: ProductItemWidget(
  //                             isKatalog: true,
  //                             indexProduct: state.products.data[index].id,
  //                             imageProduct: state.products.data[index].image,
  //                             nameProduct: state.products.data[index].name,
  //                             storeProduct: state.products.data[index].shop,
  //                             ratingProduct:
  //                                 state.products.data[index].rating ?? 0,
  //                           ),
  //                         );
  //                       } else if (!state.hasReachedMax) {
  //                         // Show loading indicator at the end if not reached max
  //                         return const Center(
  //                           child: CircularProgressIndicator(),
  //                         );
  //                       } else {
  //                         // Return an empty container when max is reached
  //                         return Container();
  //                       }
  //                     },
  //                     itemCount: state.hasReachedMax
  //                         ? state.products.data.length
  //                         : state.products.data.length + 1,
  //                   ),


                     // Future<void> _onFetchMoreProducts(
  //     FetchMoreProducts event, Emitter<ProductState> emit) async {
  //   logger.d('Fetch More Products Started - Current Page: $currentPage');

  //   if (_hasReachedMax) {
  //     logger.d('Reached max pages, stopping fetch');
  //     return;
  //   }

  //   if (state is! ProductLoaded) {
  //     logger.d('Current state is not ProductLoaded, cannot fetch more');
  //     return;
  //   }

  //   try {
  //     currentPage++;
  //     logger.d('Fetching page: $currentPage');

  //     final moreProducts = await _productRepository.fetchProducts(currentPage);

  //     totalPages = moreProducts.meta.pageCount;
  //     _hasReachedMax = currentPage >= totalPages;

  //     logger.d(
  //         'Fetched More Products - Total Pages: $totalPages, Current Page: $currentPage');
  //     logger.d('New Products Count: ${moreProducts.data.length}');

  //     final newProducts = moreProducts.data
  //         .where((newProduct) => !_allProducts
  //             .any((existingProduct) => existingProduct.id == newProduct.id))
  //         .toList();

  //     logger.d('Unique New Products Count: ${newProducts.length}');

  //     _allProducts.addAll(newProducts);

  //     emit(ProductLoaded(
  //         products: Products(
  //             statusCode: moreProducts.statusCode,
  //             message: moreProducts.message,
  //             data: List.from(_allProducts),
  //             meta: moreProducts.meta),
  //         hasReachedMax: _hasReachedMax));
  //     logger.i('Successfully fetched more products');
  //   } catch (e) {
  //     logger.e('Error fetching more products: $e');
  //     currentPage--;
  //     emit(ProductError(e.toString()));
  //   }
  // }