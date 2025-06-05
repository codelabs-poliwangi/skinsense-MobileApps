// import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/dependency_injector.dart';
import 'package:skinisense/domain/services/sharedPreferences-services.dart';
import 'package:skinisense/presentation/ui/pages/features/product/product_detail_page.dart';
import 'package:skinisense/presentation/ui/pages/features/result/bloc/get_recomendation_product/get_recomendation_product_bloc.dart';
import 'package:skinisense/presentation/ui/pages/features/result/model/last_scan_model.dart';
import 'package:skinisense/presentation/ui/widget/button_primary.dart';
import 'package:skinisense/presentation/ui/widget/product_katalog.dart';

import 'package/package_from_resul_scan_to_result_recom.dart';

class ResultRecomScope extends StatelessWidget {
  final PackageFromResulScanToResultRecom package;
  const ResultRecomScope({super.key, required this.package});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetRecomendationProductBloc(),
      child: ResultRecomPage(package: package),
    );
  }
}

class ResultRecomPage extends StatefulWidget {
  final PackageFromResulScanToResultRecom package;
  const ResultRecomPage({super.key, required this.package});

  @override
  State<ResultRecomPage> createState() => _ResultRecomPageState();
}

class _ResultRecomPageState extends State<ResultRecomPage> {
  @override
  void initState() {
    context.read<GetRecomendationProductBloc>().add(
      GetRecomendationProductFromScan(id: widget.package.id),
    );
    super.initState();
  }

  Future<String?> _fetchUserName(BuildContext context) async {
    return di<SharedPreferencesService>().getString('name') ?? 'Guest';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                background: FutureBuilder(
                  future: _fetchUserName(context),
                  builder: (context, asyncSnapshot) {
                    String userName = 'Guest';
                    if (asyncSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      userName = 'Loading...';
                    } else if (asyncSnapshot.hasError) {
                      userName = 'Error';
                    } else if (asyncSnapshot.hasData) {
                      userName = asyncSnapshot.data!;
                    }
                    return CardResultWidget(name: userName);
                  },
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: SizeConfig.calHeightMultiplier(20)),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  margin: EdgeInsets.only(
                    top: 0,
                    left: SizeConfig.calWidthMultiplier(24),
                    right: SizeConfig.calWidthMultiplier(24),
                    bottom: SizeConfig.calHeightMultiplier(16),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.calHeightMultiplier(20),
                    horizontal: SizeConfig.calHeightMultiplier(20),
                  ),
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
                        widget.package.recomDesc,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.calHeightMultiplier(12),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
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
                child:
                    BlocBuilder<
                      GetRecomendationProductBloc,
                      GetRecomendationProductState
                    >(
                      buildWhen: (previous, current) => previous != current,
                      builder: (context, state) {
                        if (state is GetRecomendationProductLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GetRecomendationProductSuccess) {
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ProductDetailPage(
                                          id: state
                                              .dataRecomendation
                                              .products[index]
                                              .id,
                                          name: state
                                              .dataRecomendation
                                              .products[index]
                                              .name,
                                          price: state
                                              .dataRecomendation
                                              .products[index]
                                              .price,
                                          rating:
                                              state
                                                  .dataRecomendation
                                                  .products[index]
                                                  .rating ??
                                              0,
                                          shop: state
                                              .dataRecomendation
                                              .products[index]
                                              .shop,
                                          image: state
                                              .dataRecomendation
                                              .products[index]
                                              .image,
                                          sold: state
                                              .dataRecomendation
                                              .products[index]
                                              .sold,
                                          linkProduct: state
                                              .dataRecomendation
                                              .products[index]
                                              .linkProduct,
                                          category: state
                                              .dataRecomendation
                                              .products[index]
                                              .category,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: ProductItemWidget(
                                  isKatalog: false,
                                  indexProduct: state
                                      .dataRecomendation
                                      .products[index]
                                      .id,
                                  imageProduct: state
                                      .dataRecomendation
                                      .products[index]
                                      .image,
                                  nameProduct: state
                                      .dataRecomendation
                                      .products[index]
                                      .name,
                                  storeProduct: state
                                      .dataRecomendation
                                      .products[index]
                                      .shop,
                                  ratingProduct:
                                      state
                                          .dataRecomendation
                                          .products[index]
                                          .rating ??
                                      0,
                                ),
                              );
                            },
                            itemCount: state.dataRecomendation.products.length,
                          );
                        } else if (state is GetRecomendationProductFailed) {
                          return Center(child: Text('Error: ${state.message}'));
                        } else {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                      },
                    ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: SizeConfig.calHeightMultiplier(20),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.all(24),
        child: ButtonPrimary(
          mainButtonMessage: "Kembali ke Home",
          mainButton: () async {
            // menghapus data yang di butuhka nuntuk peoses scan di preferences
            // String? imageRightSide =
            //                 await SharedPreferencesService().getString(
            //                   'scan_face_right',
            //                 );
            //             String? imageLeftSide = await SharedPreferencesService()
            //                 .getString('scan_face_left');
            //             String? imageFrontSide =
            //                 await SharedPreferencesService().getString(
            //                   'scan_face_front',
            //                 );
            SharedPreferencesService().removeData('scan_face_right');
            SharedPreferencesService().removeData('scan_face_left');
            SharedPreferencesService().removeData('scan_face_front');
            SharedPreferencesService().getString('last_scan');
            final sharedPrefs = SharedPreferencesService();
            final existingData = await sharedPrefs.getString('last_scan');

            LastScanModel dataLastScan = LastScanModel(
              date: DateTime.now(),
              wringkle: widget.package.wringkle,
              acne: 0,
              flex: 0,
            );

            if (existingData != null) {
              await sharedPrefs.removeData('last_scan');
            }

            // Simpan data baru
            await sharedPrefs.saveString(
              'last_scan',
              jsonEncode(dataLastScan.toJson()),
            );

            // menambah data history scan berupa date, time, dan hasil
            Navigator.pushNamedAndRemoveUntil(
              context,
              routeHome,
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}

class CardResultWidget extends StatelessWidget {
  final String name;
  const CardResultWidget({super.key, required this.name});

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
                  'Hai, $name',
                  style: TextStyle(
                    fontSize: SizeConfig.calHeightMultiplier(18),
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.calHeightMultiplier(20)),
                Text(
                  'Berikut adalah produk yang kami rekomendasikan untuk kamu!',
                  style: TextStyle(
                    fontSize: SizeConfig.calHeightMultiplier(15),
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
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
      ),
    );
  }
}
