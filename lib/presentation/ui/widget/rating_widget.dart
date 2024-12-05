import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  const RatingWidget({
    super.key, required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))  // Opsional: menambahkan radius pada container
      ),
      child: Row(
        mainAxisSize:
            MainAxisSize.min, // Membuat ukuran Row hanya sebesar isi
        children: [
          Icon(
            Icons.star,
            color: Colors.white,
            size: 16, // Menyesuaikan ukuran ikon
          ),
          SizedBox(width: 4), // Jarak antara ikon dan teks
          Text(
            rating.toString(),
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
