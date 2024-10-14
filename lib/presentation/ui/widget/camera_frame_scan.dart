
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/theme/color.dart';

class CameraFrameScan extends StatelessWidget {
  const CameraFrameScan({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          ClipPath(
            clipper: HollowRectClipper(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height -
                    MediaQuery.sizeOf(context).height *
                        .15, // Same as the outer container
                // color: Colors.blue,
              ),
            ),
          ),
          Positioned(
            left: 50,
            top: MediaQuery.sizeOf(context).height -
                MediaQuery.sizeOf(context).height * .775,
            child: Container(
              width: 60, // Set a width
              height: 60, // Set a height
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    icEdgeFrame,
                  ),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    grayEdgeFrameColor, // Color to apply
                    BlendMode.srcIn, // Blend mode
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 50,
            top: MediaQuery.sizeOf(context).height -
                MediaQuery.sizeOf(context).height * .775,
            child: Transform.rotate(
              angle: 90 *
                  (3.14159 /
                      180), // Rotate 45 degrees (convert to radians)
              child: Container(
                width: 60, // Set a width
                height: 60, // Set a height
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(icEdgeFrame),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      grayEdgeFrameColor, // Color to apply
                      BlendMode.srcIn, // Blend mode
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 50,
            top: MediaQuery.sizeOf(context).height -
                MediaQuery.sizeOf(context).height * .515,
            child: Transform.rotate(
              angle: 180 *
                  (3.14159 /
                      180), // Rotate 45 degrees (convert to radians)
              child: Container(
                width: 60, // Set a width
                height: 60, // Set a height
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(icEdgeFrame),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      grayEdgeFrameColor, // Color to apply
                      BlendMode.srcIn, // Blend mode
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 50,
            top: MediaQuery.sizeOf(context).height -
                MediaQuery.sizeOf(context).height * .515,
            child: Transform.rotate(
              angle: 270 *
                  (3.14159 /
                      180), // Rotate 45 degrees (convert to radians)
              child: Container(
                width: 60, // Set a width
                height: 60, // Set a height
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(icEdgeFrame),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      grayEdgeFrameColor, // Color to apply
                      BlendMode.srcIn, // Blend mode
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HollowRectClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    print('size height ${size.height}');
    print('size width ${size.width}');
    // Define the outer rectangle size
    Path path = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Define the inner rectangle size (the hollow part)
    // Define the inner rectangle size (the hollow part) with rounded corners
    RRect hollowRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(50, 200, size.width - size.width * 0.25,
          size.height - size.height * 0.625),
      Radius.circular(20), // Adjust the radius as needed
    );

    path = Path.combine(
        PathOperation.difference, path, Path()..addRRect(hollowRect));

    // Path topLeftBorder = Path();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
