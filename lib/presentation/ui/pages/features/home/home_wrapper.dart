import 'package:flutter/material.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/pages/features/home/home_page.dart';
import 'package:skinisense/presentation/ui/pages/features/jadwal/jadwal_page.dart';
import 'package:skinisense/presentation/ui/pages/features/komunitas/komunitas_page.dart';
import 'package:skinisense/presentation/ui/pages/features/profile/profile_page.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  late final PageController pageController;
  final List<Widget> pages = [
    HomePage(),
    JadwalPage(),
    KomunitasPage(),
    ProfilePage(),
  ];

  // Variable to track the current index
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    // Initialize pageController
    pageController = PageController();
  }

  PageView _pageViewWrapper() {
    return PageView(
      controller: pageController,
      onPageChanged: (int index) {
        setState(() {
          selectedIndex = index; // Update current index when page is swiped
        });
      },
      children: pages,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pageViewWrapper()),
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerDocked, //! agar membuat fab nya ditengah bawah
      backgroundColor: lightBlueColor,
      //! bungkus bottomnavigatorbarnya menggunakn bottomAppbar dan diberi beberapa property agar fab tidak collapse dengan bototm navigatior bar
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButton: _floatingActionScan(),
    );
  }

  FloatingActionButton _floatingActionScan() {
    return FloatingActionButton(
      backgroundColor: primaryBlueColor,
      shape: CircleBorder(),
      onPressed: () {
        Navigator.of(context).pushNamed(routeScan);
      },
      child: Image(
        width: SizeConfig.calWidthMultiplier(32),
        color: Colors.white,
        image: AssetImage(
          icScanFace,
        ),
      ),
    );
  }

  BottomAppBar _bottomNavigationBar() {
    return BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip
            .antiAlias, //! agar terdapat lengkungan diantara fab dan bottomnavigatior bar
        notchMargin: 6,
        elevation: 2,
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.calWidthMultiplier(24)),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              _bottomAppBarItem(
                context,
                icon: icHome,
                label: 'Home',
                page: 0,
              ),
              _bottomAppBarItem(context,
                  icon: icCalender, label: 'Jadwal', page: 1),
              SizedBox(
                width: SizeConfig.calWidthMultiplier(20),
              ),
              _bottomAppBarItem(context,
                  icon: icCommunity, label: 'Komunitas', page: 2),
              _bottomAppBarItem(context,
                  icon: icProfile, label: 'Profile', page: 3)
            ],
          ),
        ));
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required int page, required String label, required String icon}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = page;
          pageController.animateToPage(page, // Animate page change on tap
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut);
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: SizeConfig.calHeightMultiplier(2)),
            Container(
              child: Image(
                image: AssetImage(icon),
                height: SizeConfig.calHeightMultiplier(20),
                color: selectedIndex == page ? primaryBlueColor : grayColor,
              ),
            ),
            SizedBox(height: SizeConfig.calHeightMultiplier(10)),
            Text(
              label,
              style: TextStyle(
                color: selectedIndex == page ? primaryBlueColor : grayColor,
                fontSize: SizeConfig.calHeightMultiplier(12),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
