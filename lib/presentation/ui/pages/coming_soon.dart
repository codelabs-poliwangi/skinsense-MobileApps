import 'package:flutter/material.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/theme/color.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: lightBlueColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Stay Tuned",
                  style: TextStyle(
                    color: primaryBlueColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Image(
                  height: 200,
                  image: AssetImage(logoSplashScreen),
                ),
                SizedBox(
                  height: 18,
                ),
                Text(
                  textAlign: TextAlign.center,
                  'Fitur ini sedang dalam pengembangan. Kami akan segera meluncurkannya untuk Anda.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                  'Terima kasih atas kesabaran Anda. Nantikan pembaruan lebih lanjut!',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}