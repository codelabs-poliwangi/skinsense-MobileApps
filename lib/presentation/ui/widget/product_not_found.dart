import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class ProductNotFoudWidget extends StatelessWidget {
  final String message;
  const ProductNotFoudWidget({super.key,required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                size: 100,
                FluentSystemIcons.ic_fluent_document_search_regular,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Hasil tidak Ditemukan',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                message,
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
