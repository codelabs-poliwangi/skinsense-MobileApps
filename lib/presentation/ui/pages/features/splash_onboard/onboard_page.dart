import 'package:flutter/material.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/presentation/ui/widget/dot_indicator.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> splashData = [
    {
      "title": "Pindai Wajah Anda",
      "text":
          "Analisis kondisi kulit Anda dengan teknologi pemindaian wajah canggih kami. Dapatkan wawasan personal secara instan.",
      "image": onboardScanFace,
    },
    {
      "title": "Perawatan Kulit Personal",
      "text":
          "Terima rekomendasi perawatan kulit yang disesuaikan berdasarkan jenis kulit dan masalah kulit unik Anda.",
      "image": onboardSkincare,
    },
    {
      "title": "Bergabung dengan Komunitas",
      "text":
          "Terhubung dengan orang lain, berbagi pengalaman, dan tetap up-to-date dengan tren perawatan kulit terbaru dalam grup kami.",
      "image": onboardCommunity,
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              // flex: 2,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => Container(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: Image.asset(
                      splashData[index]["image"]!,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                height: SizeConfig.calHeightMultiplier(220),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          splashData[_currentPage]["title"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: SizeConfig.calHeightMultiplier(12)),
                        Text(
                          splashData[_currentPage]["text"]!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                    // SizedBox(height: SizeConfig .calHeightMultiplier(40)),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            splashData.length,
                            (index) => DotIndicator(
                                index: index, currentPage: _currentPage),
                          ),
                        ),
                        SizedBox(height: SizeConfig.calHeightMultiplier(20)),
                        nextButton(context),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton nextButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_currentPage < splashData.length - 1) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else {
          Navigator.of(context).pushNamed(routeLogin);
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[900],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size.fromHeight(60),
      ),
      child: Text(
        _currentPage < splashData.length - 1 ? 'Selanjutnya' : 'Mulai',
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
