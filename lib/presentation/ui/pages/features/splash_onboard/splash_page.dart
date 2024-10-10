import 'package:flutter/material.dart';
import 'package:skinisense/config/common/screen.dart';
import 'dart:async';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/common/image_assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushNamed(routeOnboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width:
              SizeConfig.calMultiplierImage(156), //! dari width logo di figma
          height:
              SizeConfig.calHeightMultiplier(191), //! dari heigh logo ddi figma
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(logoSplashScreen),
            ),
          ),
        ),
      ),
    );
  }
}
