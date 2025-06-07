import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:skinisense/config/common/image_assets.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/domain/utils/currency_rupiah.dart';
import 'package:skinisense/presentation/ui/widget/button_primary.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductDetailPage extends StatelessWidget {
  final String id;
  final String name;
  final String price;
  final double rating;
  final String shop;
  final String image;
  final String sold;
  final String linkProduct;
  final String category;

  const ProductDetailPage({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.rating,
    required this.shop,
    required this.image,
    required this.sold,
    required this.linkProduct,
    required this.category,
  });

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        child: ButtonPrimary(
          mainButtonMessage: "Kunjungi Toko",
          mainButton: () {
            _launchUrl(Uri.parse(linkProduct));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar produk
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 12,
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Padding(
                          padding: const EdgeInsets.all(24),
                          child: Image.asset(
                            imageDefault,
                            color: Colors.black38,
                          ),
                        ); // Ha
                      },
                    ),
                  ),
                  // Tombol kembali
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            FluentSystemIcons.ic_fluent_arrow_left_filled,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Nama produk
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Harga produk
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      CurrencyRupiah.formatPrice(price),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 9),
                      decoration: BoxDecoration(
                        color: primaryBlueColor,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 13),

              // Toko
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Icon(
                      FluentSystemIcons.ic_fluent_store_regular,
                      color: primaryBlueColor,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      shop,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 8),

              // Produk terjual
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    Text(
                      '$sold Sold',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    // Line vertikal
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ), // Jarak horizontal
                      width: 1, // Lebar garis vertikal
                      height: 16, // Tinggi garis vertikal
                      color: Colors.grey, // Warna garis
                    ),
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '$rating',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
