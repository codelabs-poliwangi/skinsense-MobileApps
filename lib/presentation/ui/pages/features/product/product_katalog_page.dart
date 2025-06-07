import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/dependency_injector.dart';
import 'package:skinisense/domain/model/products.dart' as Products;
import 'package:skinisense/domain/utils/logger.dart';
import 'package:skinisense/presentation/ui/pages/features/product/bloc/product_bloc.dart';
import 'package:skinisense/presentation/ui/pages/features/product/product_detail_page.dart';
import 'package:skinisense/presentation/ui/pages/features/product/repository/product_repository.dart';
import 'package:skinisense/presentation/ui/widget/product_katalog.dart';
import 'package:skinisense/presentation/ui/widget/product_katalog_loading.dart';
import 'package:skinisense/presentation/ui/widget/product_not_found.dart';

class ProductKatalogScope extends StatelessWidget {
  const ProductKatalogScope({super.key});

  @override
  Widget build(BuildContext context) {
    // setupRepositoryProduct();

    return PopScope(
      canPop: true, // Menentukan apakah halaman dapat di-pop
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          logger.i('deleted repository product on katalog page');
          // print('deleted repository product on katalog page');
          // removeRepositoryProduct();
        }
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductBloc(
              di<ProductRepository>(),
            ),
          ),
        ],
        child: const ProductKatalogPage(),
      ),
    );
  }
}

class ProductKatalogPage extends StatefulWidget {
  const ProductKatalogPage({super.key});

  @override
  State<ProductKatalogPage> createState() => _ProductKatalogPageState();
}

class _ProductKatalogPageState extends State<ProductKatalogPage> {
  // TextEditingController
  final TextEditingController _controller = TextEditingController();
  // scrollController
  final ScrollController _scrollController = ScrollController();
  // Variable untuk mengontrol visibility suffix icon
  bool _showClearButton = false;
  @override
  void initState() {
    super.initState();
    // Triggering the event to fetch products once the page is loaded
    context.read<ProductBloc>().add(FetchProducts());
    _controller.addListener(() {
      setState(() {
        _showClearButton = _controller.text.isNotEmpty;
      });
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    // Use ScrollPosition instead of direct offset comparison
    final ScrollPosition position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent * 0.9) {
      final state = context.read<ProductBloc>().state;

      logger.d('Near bottom - Current State: $state');

      if (state is ProductLoaded && !state.hasReachedMax) {
        logger.d('Triggering FetchMoreProducts');
        context.read<ProductBloc>().add(FetchProducts());
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    // Jangan lupa dispose controller
    _controller.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlueColor,
      body: SafeArea(
        child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: primaryBlueColor,
                  elevation: 0,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  bottom: PreferredSize(
                    preferredSize:
                        Size.fromHeight(SizeConfig.calHeightMultiplier(20)),
                    child: const SizedBox(),
                  ),
                  flexibleSpace: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.calHeightMultiplier(8)),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              FluentSystemIcons.ic_fluent_arrow_left_regular,
                              size: 28,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Container(
                              height: 48,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  strokeAlign: 1,
                                  width: 1,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                children: [
                                  // TextField for searching
                                  Expanded(
                                    child: TextField(
                                      controller: _controller,
                                      decoration: InputDecoration(
                                        hintText: 'Cari Product..',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        prefixIcon: Icon(
                                          FluentSystemIcons
                                              .ic_fluent_search_filled,
                                          color: Colors.grey,
                                        ),
                                        suffixIcon: _showClearButton
                                            ? IconButton(
                                                icon: Icon(Icons.close,
                                                    color: Colors.grey),
                                                onPressed: () {
                                                  _controller.clear();
                                                },
                                              )
                                            : null,
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 20),
                                      ),
                                    ),
                                  ),
                                  // Container with Search Icon on the right
                                  Container(
                                    width:
                                        40, // Set width for the container with the search icon
                                    height:
                                        50, // Adjust height to match the parent container
                                    decoration: BoxDecoration(
                                      color: primaryBlueColor.withOpacity(0.7),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(16),
                                        bottomRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: Center(
                                      child: IconButton(
                                        onPressed: () {
                                          logger.d(
                                              'searching product in view ${_controller.text}');
                                          context.read<ProductBloc>().add(
                                              SearchProduct(_controller.text));
                                        },
                                        icon: Icon(
                                          FluentSystemIcons
                                              .ic_fluent_search_filled,
                                          color: Colors.white, // Icon color
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            controller: _scrollController,
            body: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ProductLoaded) {
                  logger.d(
                      'isi dari product data di productLoaded ${state.products.data}');
                  List<Products.Datum> products =
                      context.read<ProductBloc>().allProducts;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 18),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.69,
                      ),
                      // itemCount: state.hasReachedMax
                      //                         ? state.products.data.length
                      //                         : state.products.data.length + 1,
                      itemCount: state.hasReachedMax
                          ? products.length
                          : products.length + 2,
                      itemBuilder: (context, index) {
                        if (index >= products.length &&
                            !state.hasReachedMax) {
                          return const ProductKatalogLoading();
                        }

                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ProductDetailPage(
                                    id: products[index].id,
                                    name: products[index].name,
                                    price: products[index].price,
                                    rating: products[index].rating ?? 0,
                                    shop: products[index].shop,
                                    image: products[index].image,
                                    sold: products[index].sold,
                                    linkProduct: products[index].linkProduct,
                                    category: products[index].category,
                                  );
                                },
                              ),
                            );
                          },
                          child: ProductItemWidget(
                            isKatalog: true,
                            indexProduct: products[index].id,
                            imageProduct: products[index].image,
                            nameProduct: products[index].name,
                            storeProduct: products[index].shop,
                            ratingProduct: products[index].rating ?? 0,
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is ProductNotFound) {
                  return ProductNotFoudWidget(
                    message: state.message,
                  );
                } else if (state is ProductError) {
                  return Center(
                    child: Text('Error: ${state.message}'),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            )
            // body: BlocBuilder<ProductBloc, ProductState>(
            //   builder: (context, state) {
            //     if (state is ProductInitial) {
            //       return const Center(
            //         child: Text('Please Wait'),
            //       );
            //     } else if (state is ProductLoading && state is! ProductLoaded) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (state is ProductLoaded) {
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
            //         child: ListView.builder(
            //           // controller: _scrollController,
            //           itemCount: state.hasReachedMax
            //               ? state.products.data.length
            //               : state.products.data.length + 1,
            //           itemBuilder: (context, index) {
            //             // Tambahkan loading indikator di akhir jika belum mencapai max
            //             if (index == state.products.data.length &&
            //                 !state.hasReachedMax) {
            //               return const Center(
            //                 child: Padding(
            //                   padding: EdgeInsets.all(16.0),
            //                   child: CircularProgressIndicator(),
            //                 ),
            //               );
            //             }

            //             // Hindari error jika index melebihi jumlah data
            //             if (index >= state.products.data.length) {
            //               return const SizedBox.shrink();
            //             }

            //             final product = state.products.data[index];
            //             return GestureDetector(
            //               onTap: () {
            //                 Navigator.push(context, MaterialPageRoute(
            //                   builder: (context) {
            //                     return ProductDetailPage(
            //                       id: product.id,
            //                       name: product.name,
            //                       price: product.price,
            //                       rating: product.rating ?? 0,
            //                       shop: product.shop,
            //                       image: product.image,
            //                       sold: product.sold,
            //                       linkProduct: product.linkProduct,
            //                       category: product.category,
            //                     );
            //                   },
            //                 ));
            //               },
            //               child: ProductItemWidget(
            //                 isKatalog: true,
            //                 indexProduct: product.id,
            //                 imageProduct: product.image,
            //                 nameProduct: product.name,
            //                 storeProduct: product.shop,
            //                 ratingProduct: product.rating ?? 0,
            //               ),
            //             );
            //           },
            //         ),
            //       );
            //     } else if (state is ProductError) {
            //       return Center(child: Text('Error: ${state.message}'));
            //     } else if (state is ProductNotFound) {
            //       return ProductNotFoudWidget(
            //         message: state.message,
            //       );
            //     } else {
            //       return const Center(child: Text('Something went wrong'));
            //     }
            //   },
            // ),
            ),
      ),
    );
  }
}
