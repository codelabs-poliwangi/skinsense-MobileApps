import 'package:flutter/material.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/widget/button_primary.dart';

class QuestionsIntro extends StatelessWidget {
  const QuestionsIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            footerPage(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 70,
                  ),
                  Text(
                    'Get To Know Yourself Better!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: primaryBlueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Image(
                    height: 165,
                    image: AssetImage(
                      scanFaceSmile,
                    ),
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Text(
                    'Sementara Analisis Kulit Wajahmu Kami Proses, Mari Kenal Dirimu Lebih Baik.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: primaryBlueColor,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  SizedBox(
                    height: 57,
                  ),
                  ButtonPrimary(
                    mainButtonMessage: "Next",
                    mainButton: () {
                      Navigator.pushNamed(context, routeQuestions);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align footerPage() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(right: 24, left: 24, bottom: 40),
        // color: Colors.blue, // Warna latar belakang container
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              logoSplashScreen, // Menggunakan AssetImage dengan shorthand
              height: 190, // Tinggi gambar
              color: Colors.black.withOpacity(0.2), // Mengatur opacity warna
              fit: BoxFit.cover, // Menyesuaikan ukuran gambar
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              textAlign: TextAlign.center,
              '© 2024 SCIN. All rights reserved. Unauthorized copying or distribution is prohibited.',
              style: TextStyle(
                  fontSize: 8, color: primaryBlueColor.withOpacity(0.5)),
            )
          ],
        ),
      ),
    );
  }
}
