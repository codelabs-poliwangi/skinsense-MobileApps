import 'package:flutter/material.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';

class ScanChoiceScope extends StatefulWidget {
  const ScanChoiceScope({super.key});

  @override
  State<ScanChoiceScope> createState() => _ScanChoiceScopeState();
}

class _ScanChoiceScopeState extends State<ScanChoiceScope> {
  @override
  Widget build(BuildContext context) {
    return ScanChoice();
  }
}

class ScanChoice extends StatelessWidget {
  const ScanChoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlueColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: const Text(
          'Pilih Metode Scan Wajah Anda.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageScanMethod(
                title: "Galeri", 
                image: icGallery,
                onTap: () {
                  Navigator.of(context).pushNamed(routeScanGallery);
                },
              ),
              SizedBox(width: 20),
              ImageScanMethod(
                title: "Scan Kamera", 
                image: icScanFace,
                onTap: () {
                  Navigator.of(context).pushNamed(routeScanFront);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageScanMethod extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onTap;

  const ImageScanMethod({
    super.key,
    required this.title,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 140,
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              color: lightBlueColor,
              width: 2,
            ),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                width: SizeConfig.calWidthMultiplier(40),
                color: primaryBlueColor.withOpacity(0.7),
                image: AssetImage(image),
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: primaryBlueColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}