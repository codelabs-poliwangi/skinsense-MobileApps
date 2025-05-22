import 'package:flutter/material.dart';

class CustomLogoButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;

  const CustomLogoButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Image.asset(icon, width: 50),
    );
  }
}