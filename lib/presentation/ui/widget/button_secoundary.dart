import 'package:flutter/material.dart';
import 'package:skinisense/config/theme/color.dart';

class ButtonSecoundary extends StatelessWidget {
  const ButtonSecoundary({
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
        backgroundColor: secoundaryButtonColor,
        foregroundColor: Colors.black,
        minimumSize: Size(double.infinity, 58),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        mainButtonMessage,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
    );
  }
}
