import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/dependency_injector.dart';
import 'package:skinisense/presentation/ui/pages/features/home/bloc/product_bloc.dart';
import 'package:skinisense/presentation/ui/pages/features/home/repository/product_repository.dart';
import 'package:skinisense/presentation/ui/widget/product_katalog.dart';
import 'package:skinisense/presentation/ui/widget/progress_skin.dart';
import 'package:skinisense/presentation/ui/widget/routine_list.dart';
import 'package:skinisense/presentation/ui/widget/search_textfield.dart';
import 'package:skinisense/presentation/ui/widget/alertdialog_widget.dart';

class HomePageScope extends StatelessWidget {
  const HomePageScope({super.key});

  @override
  Widget build(BuildContext context) {
    // setupRepositoryProduct();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(
            di<ProductRepository>(),
          ),
        ),
      ],
      child: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: lightBlueColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                backgroundColor: lightBlueColor,
                automaticallyImplyLeading: false,
                expandedHeight: SizeConfig.calHeightMultiplier(260),
                flexibleSpace: FlexibleSpaceBar(
                  background: CardWelcomeWidget(),
                ),
              ),
              // Jarak antara SliverAppBar pertama dan konten lainnya
              SliverToBoxAdapter(
                child: SizedBox(
                  height: SizeConfig.calHeightMultiplier(10),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SkinConditionWidget(),
                    SizedBox(height: SizeConfig.calHeightMultiplier(20)),
                    TrackRoutineWidget(),
                    SizedBox(height: SizeConfig.calHeightMultiplier(20)),
                    Container(
                      padding: EdgeInsets.only(
                        top: 0,
                        left: SizeConfig.calWidthMultiplier(24),
                        right: SizeConfig.calWidthMultiplier(24),
                        bottom: SizeConfig.calHeightMultiplier(16),
                      ),
                      child: Text(
                        'Product',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: SizeConfig.calHeightMultiplier(16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Membungkus GridView.builder di dalam SliverToBoxAdapter
              SliverToBoxAdapter(
                child: SizedBox(
                  height: SizeConfig.calHeightMultiplier(
                      1100), // Tentukan tinggi sesuai kebutuhan
                  child: BlocBuilder<ProductBloc, ProductState>(
                    // bloc: ProductBloc(di<ProductRepository>()),
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
                                  imageProduct:
                                      state.products[index].productImage,
                                  nameProduct: state.products[index].name,
                                  storeProduct: state.products[index].store,
                                  storeImage: state.products[index]
                                      .store, // Ensure correct data
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
                ),
              ),
              // Tambahkan padding di bawah
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: SizeConfig.calHeightMultiplier(20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrackRoutineWidget extends StatelessWidget {
  const TrackRoutineWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.calHeightMultiplier(24)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Track Your Routine',
            style: TextStyle(
              color: Colors.black,
              fontSize: SizeConfig.calHeightMultiplier(16),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
              height: SizeConfig.calHeightMultiplier(
                  12)), // Tambahkan sedikit jarak
          // ListView builder di dalam SliverList
          ListView.builder(
            shrinkWrap:
                true, // Diperlukan agar tidak mengambil seluruh tinggi layar
            physics:
                NeverScrollableScrollPhysics(), // Mencegah ListView ini dapat di-scroll
            itemCount: 5, // Ganti dengan jumlah elemen sebenarnya
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    // Checkbox dengan logika dinamis
                    Checkbox(
                      activeColor: primaryBlueColor,

                      value:
                          true, // Sesuaikan dengan logika state yang diinginkan
                      onChanged: (bool? value) {
                        // Aksi ketika checklist diubah
                      },
                    ),
                    // RoutineListTile dengan Expanded agar layout lebih fleksibel
                    Expanded(
                      child: RoutineListTile(
                        routineImage: onboardCommunity,
                        routineName:
                            'Use serum for morning routine to help your skin stay hydrated.',
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SkinConditionWidget extends StatelessWidget {
  const SkinConditionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.calHeightMultiplier(24)),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: SizeConfig.calHeightMultiplier(20)),
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.calWidthMultiplier(16),
            vertical: SizeConfig.calHeightMultiplier(20)),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 20,
              offset: Offset(0, 6), // Mengatur posisi bayangan
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skin Condition',
              style: TextStyle(
                color: blueTextColor,
                fontSize: SizeConfig.calHeightMultiplier(20),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Last Check : 30 Augst 2024',
              style: TextStyle(
                color: blueTextColor,
                fontSize: SizeConfig.calHeightMultiplier(10),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: SizeConfig.calHeightMultiplier(12),
            ),
            ProgressSkinWidget(
                problemSkin: 'Skin Acne', percentProblemSKin: 80),
            SizedBox(
              height: SizeConfig.calHeightMultiplier(16),
            ),
            ProgressSkinWidget(
                problemSkin: 'Skin Wringkle', percentProblemSKin: 70),
            SizedBox(
              height: SizeConfig.calHeightMultiplier(16),
            ),
            ProgressSkinWidget(
                problemSkin: 'Skin Oily', percentProblemSKin: 50),
          ],
        ),
      ),
    );
  }
}

class CardWelcomeWidget extends StatelessWidget {
  const CardWelcomeWidget({
    super.key,
  });

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
      height: SizeConfig.calHeightMultiplier(260),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.calWidthMultiplier(24),
                vertical: SizeConfig.calHeightMultiplier(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning!',
                          style: TextStyle(
                              fontSize: SizeConfig.calHeightMultiplier(16),
                              color: Colors.white),
                        ),
                        Text(
                          'Hendery Huang',
                          style: TextStyle(
                              fontSize: SizeConfig.calHeightMultiplier(20),
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.pushReplacementNamed(context, routeProductSearch);
                            Navigator.of(context).pushNamed(routeProductSearch);
                            // removeRepositoryProduct();
                          },
                          child: Icon(
                            FluentSystemIcons.ic_fluent_search_regular,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.calWidthMultiplier(16),
                        ),
                        NotificationWidget(
                          isNotification: false,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.calHeightMultiplier(40),
                ),
                Text(
                  "🌞Don't forget to use sunscreen\nand re-apply it every 3 hours🌞",
                  style: TextStyle(
                    fontSize: SizeConfig.calHeightMultiplier(16),
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
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
          )
        ],
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final bool isNotification;

  const NotificationWidget({
    Key? key,
    this.isNotification = false, // Inisialisasi default isNotification
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Icon(
          FluentSystemIcons.ic_fluent_alert_regular,
          color: Colors.white,
          size: 24,
        ),
        if (isNotification) // Kondisi untuk menampilkan posisi dan notifikasi
          Positioned(
            right: 0,
            child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }
}
