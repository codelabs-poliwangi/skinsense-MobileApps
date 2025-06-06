import 'package:flutter/material.dart';
import 'package:skinisense/config/theme/color.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    super.key,
    required this.mainButtonMessage,
    required this.mainButton,
  });
  final VoidCallback mainButton;
  final String mainButtonMessage;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: mainButton,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlueColor,
        foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, 58),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        mainButtonMessage,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
