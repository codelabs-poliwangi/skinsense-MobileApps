import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class SearchTextfield extends StatefulWidget {
  const SearchTextfield({super.key});

  @override
  State<SearchTextfield> createState() => _SearchTextfieldState();
}

class _SearchTextfieldState extends State<SearchTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(30), // Mengatur sudut rounded
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 20,
            offset: Offset(0, 6), // Mengatur posisi bayangan
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Product..', // Teks placeholder
          hintStyle: TextStyle(color: Colors.grey), // Gaya teks placeholder
          prefixIcon: Icon(FluentSystemIcons.ic_fluent_search_filled, color: Colors.grey), // Ikon pencarian
          border: InputBorder.none, // Menghapus border default
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Padding di dalam text field
        ),
      ),
    );
  }
}
