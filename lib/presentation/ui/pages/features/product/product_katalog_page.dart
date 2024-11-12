import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/domain/provider/product_provider.dart';
import 'package:skinisense/dependency_injector.dart';
import 'package:skinisense/domain/utils/logger.dart';
import 'package:skinisense/presentation/ui/pages/features/product/bloc/product_bloc.dart';
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
  @override
  void initState() {
    super.initState();
    // Triggering the event to fetch products once the page is loaded
    context.read<ProductBloc>().add(FetchProducts());
  }

  @override
  void dispose() {
    // removeRepositoryProduct();
    // TODO: implement dispose
    super.dispose();
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
                      const Expanded(child: SearchTextfield()),
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
                            Navigator.pushNamed(
                              context,
                              routeProductDetail,
                              arguments: {
                                'id': state.products[index].id.toString()
                              },
                            );
                          },
                          child: ProductItemWidget(
                            isKatalog: true,
                            indexProduct: state.products[index].id,
                            imageProduct: state.products[index].productImage,
                            nameProduct: state.products[index].name,
                            storeProduct: state.products[index].store,
                            storeImage: state
                                .products[index].store, // Ensure correct data
                            ratingProduct:
                                state.products[index].rating.toDouble(),
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
