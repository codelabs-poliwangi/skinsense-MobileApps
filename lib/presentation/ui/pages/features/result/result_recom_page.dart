// import 'package:carousel_slider/carousel_slider.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/dependency_injector.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:skinisense/domain/provider/product_provider.dart';
import 'package:skinisense/presentation/ui/pages/features/home/bloc/product_bloc.dart';
import 'package:skinisense/presentation/ui/pages/features/home/repository/product_repository.dart';
import 'package:skinisense/presentation/ui/pages/features/product/product_detail_page.dart';
import 'package:skinisense/presentation/ui/widget/custom_button.dart';
import 'package:skinisense/presentation/ui/widget/product_katalog.dart';

class ResultRecomScope extends StatelessWidget {
  const ResultRecomScope({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(ProductRepository(di<ProductProvider>())),
      child: const ResultRecomPage(),
    );
  }
}

class ResultRecomPage extends StatelessWidget {
  const ResultRecomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: null,
        backgroundColor: lightBlueColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                backgroundColor: lightBlueColor,
                automaticallyImplyLeading: false,
                expandedHeight: SizeConfig.calHeightMultiplier(280),
                flexibleSpace: FlexibleSpaceBar(
                  background: CardResultWidget(),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(height: SizeConfig.calHeightMultiplier(20)),
                    Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        margin: EdgeInsets.only(
                          top: 0,
                          left: SizeConfig.calWidthMultiplier(24),
                          right: SizeConfig.calWidthMultiplier(24),
                          bottom: SizeConfig.calHeightMultiplier(16),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: SizeConfig.calHeightMultiplier(20),
                            horizontal: SizeConfig.calHeightMultiplier(20)),
                        child: Wrap(
                          runSpacing: 10,
                          children: [
                            Text(
                              'Rekomedasi Produk',
                              style: TextStyle(
                                color: primaryBlueColor,
                                fontSize: SizeConfig.calHeightMultiplier(20),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Sesuai dengan analisis kulit kamu  yang tergolong kusam, kami merekomendasikan produk skincare yang tepat.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.calHeightMultiplier(12),
                              ),
                            ),
                            Text(
                              'Untuk mengatasi kulit kusam, Anda memerlukan produk dengan kandungan berikut:',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: SizeConfig.calHeightMultiplier(12),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              // Membungkus GridView.builder di dalam SliverToBoxAdapter
              // Wrap the BlocBuilder with SliverToBoxAdapter to handle non-sliver content
              // Tambahkan padding di bawah
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.calHeightMultiplier(20),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: SizeConfig.calHeightMultiplier(1100),
                  child: BlocBuilder<ProductBloc, ProductState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) {
                      if (state is ProductInitial) {
                        context.read<ProductBloc>().add(FetchProducts());
                        return const Center(
                          child: Text('Please Wait'),
                        );
                      } else if (state is ProductLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is ProductLoaded) {
                        return GridView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4, // Jumlah baris
                            crossAxisSpacing: 16, // Jarak antar kolom
                            mainAxisSpacing: 16, // Jarak antar baris
                            childAspectRatio:
                                1 / 0.69, // Rasio aspek untuk kotak
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
                                isKatalog: false,
                                indexProduct: state.products[index].id,
                                imageProduct: state.products[index].image,
                                nameProduct: state.products[index].name,
                                storeProduct: state.products[index].shop,
                                ratingProduct:
                                    state.products[index].rating ?? 0,
                              ),
                            );
                          },
                          itemCount: state.products.length,
                        );
                      } else if (state is ProductError) {
                        return Center(
                          child: Text('Error: ${state.message}'),
                        );
                      } else {
                        return const Center(
                          child: Text('Something went wrong'),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CardResultWidget extends StatelessWidget {
  const CardResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          color: primaryBlueColor,
        ),
        width: double.infinity,
        height: SizeConfig.calHeightMultiplier(150),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.calWidthMultiplier(24),
                vertical: SizeConfig.calHeightMultiplier(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.calHeightMultiplier(12)),
                  Text(
                    'Hai, Jennifer Lawr',
                    style: TextStyle(
                        fontSize: SizeConfig.calHeightMultiplier(18),
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: SizeConfig.calHeightMultiplier(20)),
                  Text(
                    'Berikut adalah produk yang kami rekomendasikan untuk kamu!',
                    style: TextStyle(
                        fontSize: SizeConfig.calHeightMultiplier(15),
                        color: Colors.white,
                        fontWeight: FontWeight.w300
                        ),
                  ),
                ],
              ),
            ),
            Positioned(
                right: -90,
                bottom: -135,
                child: ClipRRect(
                  child: Image(
                    height: 300,
                    image: const AssetImage(logoSplashScreen),
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
              ),
          ],
        ));
  }
}
