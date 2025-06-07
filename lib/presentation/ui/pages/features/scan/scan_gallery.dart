import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skinisense/presentation/ui/pages/features/questions/questions_intro.dart';
import 'package:skinisense/presentation/ui/widget/button_primary.dart';

import '../../../../../domain/utils/logger.dart';

class ScanGalleryScope extends StatelessWidget {
  const ScanGalleryScope({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScanGallery();
  }
}

class ScanGallery extends StatefulWidget {
  const ScanGallery({super.key});

  @override
  State<ScanGallery> createState() => _ScanGalleryState();
}

class _ScanGalleryState extends State<ScanGallery> {
  final ImagePicker _picker = ImagePicker();
  File? _frontImage;
  File? _leftImage;
  File? _rightImage;

  @override
  void initState() {
    super.initState();
    _loadSavedImages();
  }

  Future<void> _loadSavedImages() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      final frontPath = prefs.getString('scan_face_front');
      final leftPath = prefs.getString('scan_face_left');
      final rightPath = prefs.getString('scan_face_right');

      if (frontPath != null && File(frontPath).existsSync()) {
        _frontImage = File(frontPath);
      }
      if (leftPath != null && File(leftPath).existsSync()) {
        _leftImage = File(leftPath);
      }
      if (rightPath != null && File(rightPath).existsSync()) {
        _rightImage = File(rightPath);
      }
    });
  }

  Future<void> _pickAndSaveImage(String position) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      final path = pickedFile.path;
      final commpresedPath = '${path}_compressed.jpg';
      // compressed
      // compress image
      var result = await FlutterImageCompress.compressAndGetFile(
        path,
        commpresedPath,
        quality: 88,
        rotate: 180,
      );
      if (result == null) {
        logger.e('Image compression failed');
        throw Exception('Failed to compress image');
      }
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('scan_face_$position', commpresedPath);

      setState(() {
        final file = File(commpresedPath);
        if (position == 'front') _frontImage = file;
        if (position == 'left') _leftImage = file;
        if (position == 'right') _rightImage = file;
      });
    }
  }

  Widget _buildImageBox(String label, File? image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              image: image != null
                  ? DecorationImage(image: FileImage(image), fit: BoxFit.cover)
                  : null,
            ),
            child: image == null
                ? const Icon(Icons.add_a_photo, size: 40, color: Colors.grey)
                : null,
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlueColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        title: const Text(
          'Scan Menggunakan Gallery',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Text(
                "Sebelum memulai proses scan, pastikan gambar wajah yang Anda pilih, bersih dari makeup. dengan urutan depan, kiri, dan kanan",
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildImageBox(
                    'Depan',
                    _frontImage,
                    () => _pickAndSaveImage('front'),
                  ),
                  _buildImageBox(
                    'Kiri',
                    _leftImage,
                    () => _pickAndSaveImage('left'),
                  ),
                  _buildImageBox(
                    'Kanan',
                    _rightImage,
                    () => _pickAndSaveImage('right'),
                  ),
                ],
              ),
              SizedBox(height: 40),
              ButtonPrimary(
                mainButtonMessage: 'Selanjutnya',
                mainButton: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => QuestionsIntro()),
                    ModalRoute.withName('/home'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//   Widget _buildAddImageButton() {
//     return GestureDetector(
//       onTap: _pickImage,
//       child: Container(
//         width: 150,
//         height: 150,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: primaryBlueColor.withOpacity(0.5)),
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.add_photo_alternate_outlined,
//               color: primaryBlueColor,
//               size: 50,
//             ),
//             const SizedBox(height: 8),
//             Text(
//               'Tambah Gambar',
//               style: TextStyle(color: primaryBlueColor, fontSize: 12),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildImageThumbnail(int index) {
//     return Stack(
//       children: [
//         Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             image: DecorationImage(
//               image: FileImage(_selectedImages[index]),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Center(
//           child: Text(
//             _imagePositions[index],
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black45),
//           ),
//         ),
//         Positioned(
//           top: 5,
//           right: 5,
//           child: GestureDetector(
//             onTap: () => _removeImage(index),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.red.withOpacity(0.7),
//                 shape: BoxShape.circle,
//               ),
//               child: const Icon(Icons.close, color: Colors.white, size: 20),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   void _processScan(List<File> images) {
//     print('Memproses ${_selectedImages.length} gambar');
//     // Implementasi proses scan
//   }
// }
