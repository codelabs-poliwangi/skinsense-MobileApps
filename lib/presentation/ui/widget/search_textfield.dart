import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class SearchTextfield extends StatefulWidget {
  const SearchTextfield({super.key});

  @override
  State<SearchTextfield> createState() => _SearchTextfieldState();
}

class _SearchTextfieldState extends State<SearchTextfield> {
  // Tambahkan TextEditingController
  final TextEditingController _controller = TextEditingController();
  // Variable untuk mengontrol visibility suffix icon
  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    // Tambahkan listener untuk mengecek perubahan text
    _controller.addListener(() {
      setState(() {
        _showClearButton = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    // Jangan lupa dispose controller
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: _controller, // Gunakan controller
        decoration: InputDecoration(
          hintText: 'Cari Product..',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(
            FluentSystemIcons.ic_fluent_search_filled,
            color: Colors.grey
          ),
          // Tampilkan suffix icon hanya jika ada text
          suffixIcon: _showClearButton
              ? IconButton(
                  icon: Icon(Icons.close, color: Colors.grey),
                  onPressed: () {
                    // Clear text saat icon di tap
                    _controller.clear();
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        ),
      ),
    );
  }
}