import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:skinisense/config/common/screen.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/presentation/ui/widget/rating_widget.dart';

class ProductItemWidget extends StatelessWidget {
  final String indexProduct;
  final String imageProduct;
  final String nameProduct;
  final String storeProduct;
  final double ratingProduct;
  final bool isKatalog;
  const ProductItemWidget(
      {super.key,
      required this.indexProduct,
      required this.imageProduct,
      required this.nameProduct,
      required this.storeProduct,
      required this.ratingProduct,
      required this.isKatalog});

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
              height: isKatalog
                  ? MediaQuery.sizeOf(context).width * 0.425
                  : SizeConfig.calHeightMultiplier(160), // Tinggi gambar
              width: double.infinity, // Gambar mengisi lebar penuh kontainer
              decoration: BoxDecoration(
                // color: Colors.blue, // Tambahkan gambar di sini
                image: DecorationImage(
                  image: NetworkImage(imageProduct), // Gambar dari asset
                  fit: BoxFit
                      .cover, // Mengatur gambar agar sesuai dengan container
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
                        child: RichText(
                          overflow: TextOverflow.ellipsis,
                          // strutStyle: StrutStyle(fontSize: 12.0),
                          maxLines: 2,
                          text: TextSpan(
                            text: nameProduct,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.red,
                        padding: EdgeInsets.only(left: 8, top: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              color: primaryBlueColor,
                              FluentSystemIcons.ic_fluent_store_regular,
                              size: 18,
                            ),
                            SizedBox(
                                width:
                                    8), // Menambahkan jarak antara gambar dan teks
                            Expanded(
                              child: RichText(
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                text: TextSpan(
                                  text: _getStoreText(storeProduct),
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            RatingWidget(
                              rating: ratingProduct, // Rating produk
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getStoreText(String storeName) {
    List<String> words = storeName.split(' ');

    if (words.length > 1) {
      return '${words[0]}...'; // Return the first word followed by "..."
    }

    return storeName; // Return the original name if it's one word
  }
}
