import 'package:flutter/material.dart';

class PreviewPageRight extends StatefulWidget {
  const PreviewPageRight({super.key});

  @override
  State<PreviewPageRight> createState() => _PreviewPageRightState();
}

class _PreviewPageRightState extends State<PreviewPageRight> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Center(
            child: Text('Preview Scan Page Right'),
          ),
        ),
      ),
    );
  }
}
