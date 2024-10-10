import 'package:flutter/material.dart';
import 'package:skinisense/config/common/screen.dart';
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
  int currentIndex = 0;
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
          currentIndex = index; // Update current index when page is swiped
        });
      },
      children: pages,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageViewWrapper(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,//! agar membuat fab nya ditengah bawah 
      backgroundColor: ,
      //! bungkus bottomnavigatorbarnya menggunakn bottomAppbar dan diberi beberapa property agar fab tidak collapse dengan bototm navigatior bar
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButton: _floatingActionScan(),
      
    );
  }

  FloatingActionButton _floatingActionScan() {
    return FloatingActionButton(
      backgroundColor: btnPrimaryColor,
      shape: CircleBorder(),
      onPressed: () {},
      child: Image(
        width: SizeConfig.calWidthMultiplier(22),
        image: AssetImage(
          icPlusCircle,
        ),
      ),
    );
  }

  BottomAppBar _bottomNavigationBar() {
    return BottomAppBar(
      color: Colors.white,
      shape: CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias, //! agar terdapat lengkungan diantara fab dan bottomnavigatior bar
      notchMargin: 6,
      elevation: 0,
      padding: EdgeInsets.all(0),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed, //agar item dari bottomnavigator  tidak bergerak
        elevation: 0, //agar tidak ada shdow
        selectedItemColor: blueColorCarousel,
        unselectedItemColor:
            Colors.black, //saat tidak di select maka tetap menjadi  warna hitam
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontSize: SizeConfig.calMultiplierText(10),
          fontWeight: FontWeight.w500,
          height: 2.0,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: SizeConfig.calMultiplierText(10),
          fontWeight: FontWeight.w500,
          height: 2.0,
        ),
        showUnselectedLabels: true,
        items: [
          _bottomNavigationBarItem(),
          BottomNavigationBarItem(
            label: 'History',
            icon: Image(
              width: SizeConfig.calWidthMultiplier(20),
              image: AssetImage(icHistory),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Statistic',
            icon: Image(
              width: SizeConfig.calWidthMultiplier(20),
              image: AssetImage(icStatistic),
            ),
          ),
          BottomNavigationBarItem(
            label: 'Reward',
            icon: Image(
              width: SizeConfig.calWidthMultiplier(20),
              image: AssetImage(icReward),
            ),
          )
        ],
      ),
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem() {
    return BottomNavigationBarItem(
          label: 'Overview',
          icon: Image(
            color: blueColorCarousel,
            width: SizeConfig.calWidthMultiplier(20),
            image: AssetImage(
              icOverfiew,
            ),
          ),
        );
  }
}
