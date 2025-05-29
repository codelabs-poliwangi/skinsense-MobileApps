import 'dart:io'; // Untuk menggunakan File
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/domain/services/sharedPreferences-services.dart';
import 'package:skinisense/domain/utils/logger.dart';
import 'package:skinisense/presentation/ui/pages/features/questions/questions_intro.dart';
import 'package:skinisense/presentation/ui/widget/alertdialog_widget.dart';
import 'package:skinisense/presentation/ui/widget/button_primary.dart';
import 'package:skinisense/presentation/ui/widget/button_secoundary.dart';

class PreviewPageRight extends StatefulWidget {
  const PreviewPageRight({super.key});

  @override
  State<PreviewPageRight> createState() => _PreviewPageRightState();
}

class _PreviewPageRightState extends State<PreviewPageRight> {
  late Future<String?> imageRightScan;

  @override
  void initState() {
    super.initState();
    imageRightScan = SharedPreferencesService().getString('scan_face_right');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialogWidget(
                    title: 'Batalkan Pemindaian?',
                    message:
                        'Jika Anda kembali sekarang, semua foto yang telah diambil akan hilang.',
                    cancelButton: () {
                      Navigator.of(context).pop();
                    },
                    mainButton: () {
                      // Hapus gambar dari SharedPreferences
                      SharedPreferencesService().removeData('scan_face_front');
                      SharedPreferencesService().removeData('scan_face_left');
                      SharedPreferencesService().removeData('scan_face_right');
                      Navigator.of(context).pushNamed(routeHome);
                    },
                    cancelButtonMessage: 'Tetap di Sini',
                    mainButtonMessage: 'Batalkan Pemindaian',
                  );
                },
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 24),
              child: Transform.rotate(
                angle:
                    45 *
                    (3.141592653589793 / 180), // Mengubah derajat ke radian
                child: const Icon(
                  size: 40,
                  color: primaryBlueColor,
                  FluentSystemIcons.ic_fluent_add_regular,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: FutureBuilder<String?>(
                  future: imageRightScan,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error loading image'));
                    } else if (snapshot.hasData && snapshot.data != null) {
                      String imagePath = snapshot.data!;
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Wajah Kiri',
                              style: TextStyle(
                                color: primaryBlueColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(height: 20),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: SizedBox(
                                height: 400,
                                child: Image.file(
                                  File(
                                    imagePath,
                                  ), // Menampilkan gambar dari File
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: Text('No image available'));
                    }
                  },
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.125,
              child: Row(
                children: [
                  Expanded(
                    child: ButtonSecoundary(
                      mainButtonMessage: "Ambil Ulang",
                      mainButton: () {
                        // Hapus gambar di SharedPreferences
                        SharedPreferencesService().removeData(
                          'scan_face_right',
                        );
                        Navigator.of(context).pushNamed(routeScanRight);
                      },
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: ButtonPrimary(
                      mainButtonMessage: "Konfirmasi",
                      mainButton: () async {
                        String? imageRightSide =
                            await SharedPreferencesService().getString(
                              'scan_face_right',
                            );
                        String? imageLeftSide = await SharedPreferencesService()
                            .getString('scan_face_left');
                        String? imageFrontSide =
                            await SharedPreferencesService().getString(
                              'scan_face_front',
                            );
                        logger.d(imageRightSide);
                        logger.d(imageLeftSide);
                        logger.d(imageFrontSide);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => QuestionsIntro()),
                          ModalRoute.withName('/home'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
