import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/dependency_injector.dart';
import 'package:skinisense/domain/provider/product_provider.dart';
import 'package:skinisense/domain/services/sharedPreferences-services.dart';
import 'package:skinisense/presentation/ui/pages/features/home/bloc/product_bloc.dart';
import 'package:skinisense/presentation/ui/pages/features/home/bloc/routine_bloc.dart';
import 'package:skinisense/presentation/ui/pages/features/home/bloc/skin_condition_bloc.dart';
import 'package:skinisense/presentation/ui/pages/features/home/repository/product_repository.dart';
import 'package:skinisense/presentation/ui/pages/features/home/repository/routine_repository.dart';
import 'package:skinisense/presentation/ui/pages/features/home/repository/skin_condition_repository.dart';
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
            ProductRepository(
              di<ProductProvider>(),
            ),
            // di<ProductRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => SkinConditionBloc(di<SkinConditionRepository>()),
        ),
        BlocProvider(
          create: (context) => RoutineBloc(di<RoutineRepository>()),
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
              // Wrap the BlocBuilder with SliverToBoxAdapter to handle non-sliver content
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
                                storeImage: state.products[index].store,
                                ratingProduct:
                                    state.products[index].rating.toDouble(),
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
          BlocBuilder<RoutineBloc, RoutineState>(
            builder: (context, state) {
              if (state is RoutineInitial) {
                context.read<RoutineBloc>().add(FetchRoutine());
                return const Center(
                  child: Text('Please Wait'),
                );
              } else if (state is RoutineLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is RoutineOnLoaded) {
                Logger().d(state);
                return ListView.builder(
                  shrinkWrap:
                      true, // Diperlukan agar tidak mengambil seluruh tinggi layar
                  physics:
                      NeverScrollableScrollPhysics(), // Mencegah ListView ini dapat di-scroll
                  itemCount: state.routines.length, // Ganti dengan jumlah elemen sebenarnya
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 16),
                      child: Row(
                        children: [
                          // Checkbox dengan logika dinamis
                          Checkbox(
                            activeColor: primaryBlueColor,

                            value:
                                state.routines[index].isComplete, // Sesuaikan dengan logika state yang diinginkan
                            onChanged: (bool? value) {
                               context.read<RoutineBloc>().add(ToggleRoutineComplete(index));
                              // Aksi ketika checklist diubah
                            },
                          ),
                          // RoutineListTile dengan Expanded agar layout lebih fleksibel
                          Expanded(
                            child: RoutineListTile(
                              routineImage: state.routines[index].image,
                              routineName:
                                  state.routines[index].activity,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (state is RoutineError) {
                return Center(
                  child: Text('Error: ${state.Message}'),
                );
              } else {
                return const Center(
                  child: Text('Something went wrong'),
                );
              }
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
        child: BlocBuilder<SkinConditionBloc, SkinConditionState>(
          builder: (context, state) {
            if (state is SkinConditionInitial) {
              context.read<SkinConditionBloc>().add(FetchSkinCondition());
              return const Center(
                child: Text('Please Wait'),
              );
            } else if (state is SkinConditionLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SkinConditionLoaded) {
              return Column(
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
                    'Last Check : ${state.skinCondition.lastCheck}',
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
                      problemSkin: 'Skin Acne',
                      percentProblemSKin: state.skinCondition.acne),
                  SizedBox(
                    height: SizeConfig.calHeightMultiplier(16),
                  ),
                  ProgressSkinWidget(
                      problemSkin: 'Skin Wringkle',
                      percentProblemSKin: state.skinCondition.wringkle),
                  SizedBox(
                    height: SizeConfig.calHeightMultiplier(16),
                  ),
                  ProgressSkinWidget(
                      problemSkin: 'Skin Flex',
                      percentProblemSKin: state.skinCondition.flex),
                ],
              );
            } else if (state is SkinConditionError) {
              return Text(state.message);
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

class CardWelcomeWidget extends StatelessWidget {
  const CardWelcomeWidget({super.key});

  Future<String?> _fetchUserName(BuildContext context) async {
    return di<SharedPreferencesService>().getString('name') ?? 'Guest';
  }

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
      child: FutureBuilder<String?>(
        future: _fetchUserName(context),
        builder: (context, snapshot) {
          String userName = 'Guest';
          if (snapshot.connectionState == ConnectionState.waiting) {
            userName = 'Loading...';
          } else if (snapshot.hasError) {
            userName = 'Error';
          } else if (snapshot.hasData) {
            userName = snapshot.data!;
          }

          return Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.calWidthMultiplier(24),
                  vertical: SizeConfig.calHeightMultiplier(16),
                ),
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
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              userName,
                              style: TextStyle(
                                fontSize: SizeConfig.calHeightMultiplier(20),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(routeProductSearch);
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
              ),
            ],
          );
        },
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
