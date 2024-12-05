import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skinisense/config/common/image_assets.dart';

class CameraFrameScan extends StatelessWidget {
  final String sideScan;
  const CameraFrameScan({
    super.key,
    required this.sideScan,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // Background Blur with Hollow Rectangle
          ClipPath(
            clipper: HollowRectClipper(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                color: Colors.transparent,
              ),
            ),
          ),
          
          // Centered Text
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            child: Text(
              'Ambil Foto Wajah Sisi $sideScan',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          
          // Top-Left EdgeFrame
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.sizeOf(context).width * 0.1,
                top: MediaQuery.sizeOf(context).height * 0.24,
              ),
              child: const EdgeFrameWidget(
                rotationAngle: 0,
                color: Colors.grey,
              ),
            ),
          ),
          
          // Top-Right EdgeFrame
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.sizeOf(context).width * 0.1,
                top: MediaQuery.sizeOf(context).height * 0.24 ,
              ),
              child: const EdgeFrameWidget(
                rotationAngle: 90,
                color: Colors.grey,
              ),
            ),
          ),
          
          // Bottom-Right EdgeFrame
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(
                right: MediaQuery.sizeOf(context).width * 0.1,
                bottom: MediaQuery.sizeOf(context).height * 0.24,
              ),
              child: const EdgeFrameWidget(
                rotationAngle: 180,
                color: Colors.grey,
              ),
            ),
          ),
          
          // Bottom-Left EdgeFrame
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: MediaQuery.sizeOf(context).width * 0.1,
                bottom: MediaQuery.sizeOf(context).height * 0.24,
              ),
              child: const EdgeFrameWidget(
                rotationAngle: 270,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// EdgeFrame Widget for reusability
class EdgeFrameWidget extends StatelessWidget {
  final double rotationAngle;
  final Color color;

  const EdgeFrameWidget({
    super.key,
    required this.rotationAngle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationAngle * (3.14159 / 180),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage(icEdgeFrame), // ganti dengan path gambar Anda
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              color,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

// HollowRectClipper with rounded inner rectangle
class HollowRectClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    RRect hollowRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.1,
        size.height * 0.25,
        size.width * 0.8,
        size.height * 0.5,
      ),
      const Radius.circular(20),
    );
    return Path.combine(PathOperation.difference, path, Path()..addRRect(hollowRect));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
