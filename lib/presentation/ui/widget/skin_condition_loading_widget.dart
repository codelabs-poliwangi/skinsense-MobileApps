import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skinisense/config/common/screen.dart';

class SkinConditionLoadingWidget extends StatelessWidget {
  const SkinConditionLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[200]!,
            child: SizedBox(
              height: 20,
              width: 80,
            )),
        Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[200]!,
            child: SizedBox(
              height: 10,
              width: 90,
            )),
        SizedBox(
          height: SizeConfig.calHeightMultiplier(12),
        ),
        Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[200]!,
            child: SizedBox(
              height: 28,
              width: double.infinity,
            )),
        SizedBox(
          height: SizeConfig.calHeightMultiplier(16),
        ),
        Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[200]!,
            child: SizedBox(
              height: 28,
              width: double.infinity,
            )),
        SizedBox(
          height: SizeConfig.calHeightMultiplier(16),
        ),
        Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[200]!,
            child: SizedBox(
              height: 28,
              width: double.infinity,
            )),
      ],
    );
  }
}
