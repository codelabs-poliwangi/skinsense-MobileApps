import 'package:flutter/material.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/presentation/ui/widget/dot_indicator.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> splashData = [
    {
      "title": "Scan Your Face",
      "text":
          "Analyze your skin condition with our advanced facial scanning technology. Get instant personalized insights.",
      "image": logoOnboardCommunity,
    },
    {
      "title": "Personalized Skincare",
      "text":
          "Receive tailored skincare recommendations based on your unique skin type and concerns.",
      "image": logoOnboardCommunity,
    },
    {
      "title": "Join the Community",
      "text":
          "Connect with others, share experiences, and stay up-to-date with the latest skincare trends in our group.",
      "image": logoOnboardCommunity,
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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SafeArea(
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
                  itemBuilder: (context, index) => Image.asset(
                    splashData[index]["image"]!,
                  ),
                ),
              ),
              Container(
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
            ],
          ),
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
