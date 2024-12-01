import 'package:flutter/material.dart';
import 'package:skinisense/config/common/screen.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Not Found',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: SizeConfig.calMultiplierText(24),
          ),
        ),
      ),
    );
  }
}
