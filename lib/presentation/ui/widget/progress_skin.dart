import 'package:flutter/material.dart';
import 'package:skinisense/config/theme/color.dart';

class ProgressSkinWidget extends StatelessWidget {
  final String problemSkin;
  final int percentProblemSKin;
  const ProgressSkinWidget(
      {super.key, required this.problemSkin, required this.percentProblemSKin});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryBlueColor,
            secoundaryBlueColor,
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            problemSkin,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          Text(
            '${percentProblemSKin.toString()}%',
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
          )
        ],
      ),
    );
  }
}
