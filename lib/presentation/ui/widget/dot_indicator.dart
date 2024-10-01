import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final int index;
  final int currentPage;

  const DotIndicator({
    super.key,
    required this.index,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.blue[900] : Colors.grey,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}