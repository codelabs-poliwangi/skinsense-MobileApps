import 'package:flutter/material.dart';

class PreviewPageLeft extends StatefulWidget {
  const PreviewPageLeft({super.key});

  @override
  State<PreviewPageLeft> createState() => _PreviewPageLeftState();
}

class _PreviewPageLeftState extends State<PreviewPageLeft> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text('Preview Scan Page Left'),
          ),
        ),
      ),
    );
  }
}
