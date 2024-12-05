import 'package:flutter/material.dart';
import 'package:skinisense/config/theme/color.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color backgroundColor;
  final double fontSize;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.backgroundColor = primaryBlueColor,
    this.fontSize = 18.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: backgroundColor,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
