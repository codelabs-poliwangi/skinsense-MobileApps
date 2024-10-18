import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/widget/product_katalog.dart';
import 'package:skinisense/presentation/ui/widget/progress_skin.dart';
import 'package:skinisense/presentation/ui/widget/routine_list.dart';
import 'package:skinisense/presentation/ui/widget/search_textfield.dart';
import 'package:skinisense/presentation/ui/widget/alertdialog_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlueColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              backgroundColor: lightBlueColor,
              expandedHeight: SizeConfig.calHeightMultiplier(260),
              flexibleSpace: FlexibleSpaceBar(
                background: CardWelcomeWidget(),
              ),
            ),
            // Tambahkan jarak (space) di antara dua SliverAppBar
            SliverToBoxAdapter(
              child: SizedBox(
                height: SizeConfig.calHeightMultiplier(10),
              ), // Jarak 10dp antara SliverAppBar pertama dan kedua
            ),
            SliverAppBar(
              backgroundColor: lightBlueColor,
              elevation: 0,
              pinned: true,
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(SizeConfig.calHeightMultiplier(20)),
                child: SizedBox(),
              ),
              flexibleSpace: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.calHeightMultiplier(24)),
                child: Center(child: SearchTextfield()),
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
                        bottom: SizeConfig.calHeightMultiplier(16)),
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
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom
                  crossAxisSpacing: 16, // Jarak antar kolom
                  mainAxisSpacing: 16, // Jarak antar baris
                  childAspectRatio: 0.68, // Rasio aspek untuk kotak
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ProductItemWidget(
                    indexProduct: index,
                    imageProduct: onboardCommunity,
                    nameProduct:
                        "Skintific 2% Salicylic Acid Anti Acne Serum 20ml",
                    storeProduct: 'Skintific',
                    storeImage: logoSplashScreen,
                    ratingProduct: 4.3,
                  );
                },
                itemCount: 8, // Jumlah item di grid
              ),
            ),
            SliverPadding(
                padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.calHeightMultiplier(20)))
          ],
        ),
      ),
    );
  }
}

class ProductGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Product',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: SizeConfig.calHeightMultiplier(16),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SliverGrid.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Jumlah kolom
              crossAxisSpacing: 10, // Jarak antar kolom
              mainAxisSpacing: 10, // Jarak antar baris
              childAspectRatio: 1, // Rasio aspek untuk kotak
            ),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.blueAccent, // Warna latar belakang kotak
                child: Center(
                  child: Text(
                    'Item $index', // Teks di dalam kotak
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
            itemCount: 20, // Jumlah item di grid
          ),
        ],
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
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.calHeightMultiplier(24)),
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
          SizedBox(height: SizeConfig.calHeightMultiplier(12)), // Tambahkan sedikit jarak
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
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.calHeightMultiplier(24)),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: SizeConfig.calHeightMultiplier(20)),
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.calWidthMultiplier(16), vertical: SizeConfig.calHeightMultiplier(20)),
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
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.calWidthMultiplier(24), vertical: SizeConfig.calHeightMultiplier(16)),
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
                          style: TextStyle(fontSize: SizeConfig.calHeightMultiplier(16), color: Colors.white),
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
                    NotificationWidget(
                      isNotification: false,
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
