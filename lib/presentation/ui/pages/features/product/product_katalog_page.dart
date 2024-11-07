import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/widget/product_katalog.dart';
import 'package:skinisense/presentation/ui/widget/search_textfield.dart';

class ProductKatalogPage extends StatefulWidget {
  const ProductKatalogPage({super.key});

  @override
  State<ProductKatalogPage> createState() => _ProductKatalogPageState();
}

class _ProductKatalogPageState extends State<ProductKatalogPage> {
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
                child: SizedBox(),
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
                          Navigator.of(context).pushNamed(routeProductSearch);
                        },
                        child: Icon(
                          FluentSystemIcons.ic_fluent_arrow_left_regular,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(child: SearchTextfield()),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(padding: EdgeInsets.symmetric(vertical: 10)),
            // Grid untuk katalog produk
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              sliver: SliverGrid.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom
                  crossAxisSpacing: 8, // Jarak antar kolom
                  mainAxisSpacing: 8, // Jarak antar baris
                  childAspectRatio: 0.69, // Rasio aspek untuk kotak
                ),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        routeProductDetail,
                        arguments: {'id': index.toString()},
                      );
                    },
                    child: ProductItemWidget(
                      indexProduct: index,
                      imageProduct: onboardCommunity,
                      nameProduct:
                          "Skintific 2% Salicylic Acid Anti Acne Serum 20ml",
                      storeProduct: 'Skintific',
                      storeImage: logoSplashScreen,
                      ratingProduct: 4.3,
                    ),
                  );
                },
                itemCount: 8, // Jumlah item di grid
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
    );
  }
}
