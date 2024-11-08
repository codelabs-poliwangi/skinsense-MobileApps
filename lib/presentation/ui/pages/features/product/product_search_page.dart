import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/widget/product_katalog.dart';
import 'package:skinisense/presentation/ui/widget/search_textfield.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage({super.key});

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: primaryBlueColor,
              automaticallyImplyLeading: false,
              elevation: 0,
              expandedHeight: SizeConfig.calHeightMultiplier(40),
              pinned: true,
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
                          Navigator.of(context)
                              .pushReplacementNamed(routeHome);
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
                      SizedBox(
                        width: 8,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(routeProductKatalog);
                        },
                        child: Text(
                          'Cari',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverList.builder(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      'Product $index',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  );
                },
                itemCount: 8, // Jumlah item di grid
              ),
            ),
          ],
        ),
      ),
    );
  }
}
