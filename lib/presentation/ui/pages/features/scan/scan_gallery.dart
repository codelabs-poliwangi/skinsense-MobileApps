import 'dart:io';
import 'package:flutter/material.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:image_picker/image_picker.dart';

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
  final List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  final List<String> _imagePositions = ['Depan', 'Kiri', 'Kanan'];

  Future<void> _pickImage() async {
    if (_selectedImages.length >= 3) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Maksimal 3 gambar')));
      return;
    }

    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImages.add(File(pickedFile.path));
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal memilih gambar: $e')));
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                "Sebelum memulai proses scan, pastikan gambar wajah yang Anda pilih, bersih dari makeup.",
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),

              // Tombol upload di tengah
              if (_selectedImages.isEmpty)
                Center(
                  child: Column(
                    children: [
                      _buildAddImageButton(),
                      const SizedBox(height: 16),
                      Text(
                        'Upload Gambar Anda',
                        style: TextStyle(
                          color: primaryBlueColor.withOpacity(0.5),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 20),
              // Grid untuk menampilkan gambar yang dipilih
              if (_selectedImages.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _selectedImages.length,
                  itemBuilder: (context, index) {
                    return _buildImageThumbnail(index);
                  },
                ),

              // Tombol tambah gambar jika sudah ada gambar
              if (_selectedImages.isNotEmpty && _selectedImages.length < 3)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: _buildAddImageButton(),
                ),

              SizedBox(height: 20),
              // Tombol proses scan
              if (_selectedImages.isNotEmpty)
                ElevatedButton(
                  onPressed: _processScan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryBlueColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Proses Scan'),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddImageButton() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: primaryBlueColor.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              color: primaryBlueColor,
              size: 50,
            ),
            const SizedBox(height: 8),
            Text(
              'Tambah Gambar',
              style: TextStyle(color: primaryBlueColor, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageThumbnail(int index) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: FileImage(_selectedImages[index]),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Text(
            _imagePositions[index],
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.black45),
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
          child: GestureDetector(
            onTap: () => _removeImage(index),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.7),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  void _processScan() {
    print('Memproses ${_selectedImages.length} gambar');
    // Implementasi proses scan
  }
}
