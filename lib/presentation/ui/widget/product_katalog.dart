import 'package:flutter/material.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/presentation/ui/widget/rating_widget.dart';

class ProductItemWidget extends StatelessWidget {
  final int indexProduct;
  final String imageProduct;
  final String nameProduct;
  final String storeProduct;
  final String storeImage;
  final double ratingProduct;

  const ProductItemWidget({super.key, required this.indexProduct, required this.imageProduct, required this.nameProduct, required this.storeProduct, required this.storeImage, required this.ratingProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 1000, // Tinggi container diatur
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang kotak
        borderRadius: BorderRadius.circular(8), // Membuat sudut membulat
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4), // Posisi bayangan
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Mengatur elemen agar sejajar kiri
        children: [
          // Gambar produk
          ClipRRect(
            borderRadius:
                BorderRadius.circular(8), // Memberikan radius pada gambar
            child: Container(
              height: 160, // Tinggi gambar
              width: double.infinity, // Gambar mengisi lebar penuh kontainer
              decoration: BoxDecoration(
                // color: Colors.blue, // Tambahkan gambar di sini
                image: DecorationImage(
                  image: AssetImage(imageProduct), // Gambar dari asset
                  fit: BoxFit.cover, // Mengatur gambar agar sesuai dengan container
                ),
              ),
            ),
          ),
          const SizedBox(height: 8), // Jarak antara gambar dan konten

          // Expanded digunakan agar elemen di dalam Column memenuhi tinggi container
          Expanded(
            child: Container(
              width: double.infinity,
              // padding: EdgeInsets.only(bottom: ),
              decoration: BoxDecoration(
                // color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              // padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '${nameProduct}', // Nama produk
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        // color: Colors.red,
                        padding: EdgeInsets.only(left: 8),
                        child: Row(
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  // Menambahkan border
                                  color: Colors.grey, // Warna border
                                  width: 1, // Ketebalan border
                                ),
                                image: DecorationImage(
                                  image: AssetImage(
                                      storeImage), // Gambar di dalam lingkaran
                                  fit: BoxFit
                                      .cover, // Mengatur gambar agar sesuai dengan lingkaran
                                ),
                              ),
                            ),
                            SizedBox(
                                width:
                                    6), // Menambahkan jarak antara gambar dan teks
                            Text(storeProduct)
                          ],
                        ),
                      )

                      
                    ],
                  ),
                  Positioned(
                    right: 0,
                    bottom: 10,
                    child: RatingWidget(
                      rating: ratingProduct, // Rating produk
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
