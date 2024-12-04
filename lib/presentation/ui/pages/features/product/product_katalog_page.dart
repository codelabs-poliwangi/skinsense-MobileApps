import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/dependency_injector.dart';
import 'package:skinisense/domain/utils/logger.dart';
import 'package:skinisense/presentation/ui/pages/features/product/bloc/product_bloc.dart';
import 'package:skinisense/presentation/ui/pages/features/product/product_detail_page.dart';
import 'package:skinisense/presentation/ui/pages/features/product/repository/product_repository.dart';
import 'package:skinisense/presentation/ui/widget/product_katalog.dart';
import 'package:skinisense/presentation/ui/widget/search_textfield.dart';

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
  // Tambahkan TextEditingController
  final TextEditingController _controller = TextEditingController();
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
  }

  @override
  void dispose() {
    super.dispose();
    // Jangan lupa dispose controller
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
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
                                    hintStyle: TextStyle(color: Colors.grey),
                                    prefixIcon: Icon(
                                      FluentSystemIcons.ic_fluent_search_filled,
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
                                      context
                                          .read<ProductBloc>()
                                          .add(SearchProduct(_controller.text));
                                    },
                                    icon: Icon(
                                      FluentSystemIcons.ic_fluent_search_filled,
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
            const SliverPadding(padding: EdgeInsets.symmetric(vertical: 10)),

            // BlocBuilder wrapping SliverGrid
            BlocBuilder<ProductBloc, ProductState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                if (state is ProductInitial) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('Please Wait'),
                    ),
                  );
                } else if (state is ProductLoading) {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is ProductLoaded) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    sliver: SliverGrid.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.69,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailPage(
                                  id: state.products[index].id,
                                  name: state.products[index].name,
                                  price: state.products[index].price,
                                  rating: state.products[index].rating ?? 0,
                                  shop: state.products[index].shop,
                                  image: state.products[index].image,
                                  sold: state.products[index].sold,
                                  linkProduct:
                                      state.products[index].linkProduct,
                                  category: state.products[index].category,
                                );
                              },
                            ));
                          },
                          child: ProductItemWidget(
                            isKatalog: true,
                            indexProduct: state.products[index].id,
                            imageProduct: state.products[index].image,
                            nameProduct: state.products[index].name,
                            storeProduct: state.products[index].shop,
                            ratingProduct: state.products[index].rating ?? 0,
                          ),
                        );
                      },
                      itemCount: state.products.length,
                    ),
                  );
                } else if (state is ProductError) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text('Error: ${state.message}'),
                    ),
                  );
                } else if (state is ProductNotFound) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24 ,vertical: 40),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              size: 100,
                              FluentSystemIcons.ic_fluent_document_search_regular,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Hasil tidak Ditemukan',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              '${state.message}',
                              style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SliverToBoxAdapter(
                    child: Center(
                      child: Text('Something went wrong'),
                    ),
                  );
                }
              },
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.calHeightMultiplier(20)),
            ),
          ],
        ),
      ),
    );
  }
}
