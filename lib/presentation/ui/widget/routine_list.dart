import 'package:flutter/material.dart';

class RoutineListTile extends StatelessWidget {
  final String routineName;
  final String? routineImage; // Menggunakan nullable untuk image

  const RoutineListTile({
    super.key,
    required this.routineName,
    this.routineImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 12,
            offset: Offset(0, 6), // Mengatur posisi bayangan
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(12), // Menambahkan padding
      child: Row(
        children: [
          // Cek apakah routineImage ada, jika tidak null maka tampilkan gambar
          if (routineImage != null)
            Image.asset(
              routineImage!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
          else
            SizedBox.shrink(), // Placeholder jika tidak ada gambar
          SizedBox(width: 12), // Tambahkan jarak antara gambar dan teks
          Expanded( // Menggunakan Expanded agar teks tidak terpotong
            child: Text(
              routineName,
              maxLines: 3, // Menambahkan maxLines untuk membatasi teks
              overflow: TextOverflow.ellipsis, // Mengatur overflow teks
              style: TextStyle(
                fontSize: 10, // Atur ukuran teks sesuai kebutuhan
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
