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
  int selectedIndex = 0;

  final List<Widget> pages = [
    HomePageScope(),
    JadwalPageScope(),
    KomunitasPageScope(),
    ProfilePageScope(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: pages[selectedIndex],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: lightBlueColor,
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButton: _floatingActionScan(),
    );
  }

  FloatingActionButton _floatingActionScan() {
    return FloatingActionButton(
      backgroundColor: primaryBlueColor,
      shape: CircleBorder(),
      onPressed: () {
        Navigator.of(context).pushNamed(routeScanChoice);
        // Navigator.of(context).pushNamed(routeScanFront);
        // Navigator.of(context).pushNamed(routeResultScan);
      },
      child: Image(
        width: SizeConfig.calWidthMultiplier(32),
        color: Colors.white,
        image: AssetImage(icScanFace),
      ),
    );
  }

  BottomAppBar _bottomNavigationBar() {
    return BottomAppBar(
      color: Colors.white,
      shape: CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      notchMargin: 6,
      elevation: 2,
      padding:
          EdgeInsets.symmetric(horizontal: SizeConfig.calWidthMultiplier(24)),
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
          SizedBox(width: SizeConfig.calWidthMultiplier(20)),
          _bottomAppBarItem(context,
              icon: icCommunity, label: 'Komunitas', page: 2),
          _bottomAppBarItem(context, icon: icProfile, label: 'Profile', page: 3)
        ],
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required int page, required String label, required String icon}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = page;
        });
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: SizeConfig.calHeightMultiplier(2)),
            Image(
              image: AssetImage(icon),
              height: SizeConfig.calHeightMultiplier(20),
              color: selectedIndex == page ? primaryBlueColor : grayColor,
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
