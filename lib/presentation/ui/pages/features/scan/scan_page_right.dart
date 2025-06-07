import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/config/theme/color.dart';
import 'package:skinisense/domain/services/sharedPreferences-services.dart';
import 'package:skinisense/presentation/ui/widget/alertdialog_widget.dart';
import 'package:skinisense/presentation/ui/widget/camera_frame_scan.dart';

import '../../../../../domain/utils/logger.dart';

late List<CameraDescription> _cameras; // List camera use

class ScanPageRight extends StatefulWidget {
  const ScanPageRight({super.key});

  @override
  State<ScanPageRight> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPageRight> {
  late CameraController controller;
  bool _isCameraPermissionGranted = false;
  bool _isCameraInitialized = false;
  int _selectedCameraIndex = 0; // Track current camera rear/front
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  // Function to request camera permission
  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.request();

    if (status.isGranted) {
      setState(() {
        _isCameraPermissionGranted = true;
      });
      _initializeCameras(); // Initialize cameras after permission is granted
    } else if (status.isDenied) {
      print('Camera permission denied');
      _showPermissionDialog();
    } else if (status.isPermanentlyDenied) {
      _showSettingsDialog();
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogWidget(
          title: 'Izin Kamera Diperlukan',
          message:
              'Agar aplikasi Skini dapat berfungsi dengan baik, kami memerlukan akses ke kamera Anda.',
          cancelButton: () {
            Navigator.of(context).pop();
          },
          mainButton: () async {
            var status = await Permission.camera.request();
            if (status.isGranted) {
              Navigator.of(context).pop();
              _initializeCameras();
            } else {
              Navigator.of(context).pushNamed(routeHome);
            }
          },
          cancelButtonMessage: 'Nanti saja',
          mainButtonMessage: 'Berikan Izin',
        );
      },
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialogWidget(
          title: 'Izin Kamera Diperlukan',
          message:
              'Buka pengaturan dan berikan izin kamera agar aplikasi dapat menggunakan kamera.',
          cancelButton: () {
            Navigator.of(context).pushNamed(routeHome);
          },
          mainButton: () async {
            await openAppSettings();
          },
          cancelButtonMessage: 'Batalkan',
          mainButtonMessage: 'Buka Pengaturan',
        );
      },
    );
  }

  // Function to load available cameras and initialize the first one
  Future<void> _initializeCameras() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        _initializeCamera(_cameras[_selectedCameraIndex]);
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialogWidget(
              title: 'Oh No, Ada Yang Salah Dengan Kamera',
              message:
                  'Terjadi kesalahan saat membuka kamera. Silakan coba lagi.',
              cancelButton: () {
                Navigator.of(context).pushNamed(routeHome);
              },
              mainButton: () {
                Navigator.of(context).pushNamed(routeHome);
              },
              cancelButtonMessage: 'Batalkan',
              mainButtonMessage: 'Kembali Ke Home',
            );
          },
        );
        print('No cameras available');
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialogWidget(
            title: 'Oh No, Ada Yang Salah Dengan Kamera',
            message:
                'Terjadi kesalahan saat membuka kamera. Silakan coba lagi.',
            cancelButton: () {
              Navigator.of(context).pushNamed(routeHome);
            },
            mainButton: () {
              Navigator.of(context).pushNamed(routeHome);
            },
            cancelButtonMessage: 'Batalkan',
            mainButtonMessage: 'Kembali Ke Home',
          );
        },
      );
      print('Error loading cameras: $e');
    }
  }

  // Function to initialize the camera
  void _initializeCamera(CameraDescription cameraDescription) {
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      enableAudio: false,
    );
    controller
        .initialize()
        .then((_) {
          if (!mounted) {
            return;
          }
          setState(() {
            _isCameraInitialized = true;
          });
        })
        .catchError((Object e) {
          if (e is CameraException) {
            switch (e.code) {
              case 'CameraAccessDenied':
                print('Camera access denied');
                _showPermissionDialog();
                break;
              default:
                print('Camera error: ${e.code}');
                break;
            }
          }
        });
  }

  void switchCamera() {
    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
    _initializeCamera(_cameras[_selectedCameraIndex]);
  }

  Future<void> toggleFlash() async {
    if (_isFlashOn) {
      await controller.setFlashMode(FlashMode.off);
    } else {
      await controller.setFlashMode(FlashMode.torch);
    }
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
  }

  Future<void> takePicture() async {
    if (!controller.value.isInitialized) {
      print('Error: Camera is not initialized');
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialogWidget(
            title: 'Oh No, Ada Yang Salah Dengan Kamera',
            message:
                'Terjadi kesalahan saat membuka kamera. Silakan coba lagi.',
            cancelButton: () {
              return;
            },
            mainButton: () {
              Navigator.of(context).pushNamed(routeHome);
            },
            cancelButtonMessage: 'Batalkan',
            mainButtonMessage: 'Kembali Ke Home',
          );
        },
      );
      return;
    }

    try {
      // get pic
      XFile picture = await controller.takePicture();
      int sizeInBytes = await picture.length();
      String compressedPath = '${picture.path}_compressed.jpg';
      double sizeInMB = sizeInBytes / (1024 * 1024);
      logger.d('size picture ${sizeInMB}');

      // compress image
      var result = await FlutterImageCompress.compressAndGetFile(
        picture.path,
        compressedPath,
        quality: 88,
        rotate: 180,
      );
      if (result == null) {
        logger.e('Image compression failed');
        throw Exception('Failed to compress image');
      }

      // get compressed size
      int compressedSizeInBytes = await result.length();
      double compressedSizeInMB = compressedSizeInBytes / (1024 * 1024);
      logger.d(
        'Compressed picture size: ${compressedSizeInMB.toStringAsFixed(2)} MB',
      );

      // save pic
      SharedPreferencesService().saveString('scan_face_right', picture.path);
      print('Picture saved to ${picture.path}');
      Navigator.of(context).pushNamed(routeScanRightPreview);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialogWidget(
            title: 'Oh No, Ada Yang Salah Dengan Kamera',
            message:
                'Terdapat kesalahan saat mengambil gambar. Silakan coba lagi.',
            cancelButton: () {
              return;
            },
            mainButton: () {
              Navigator.of(context).pushNamed(routeHome);
            },
            cancelButtonMessage: 'Batalkan',
            mainButtonMessage: 'Kembali Ke Home',
          );
        },
      );
      print('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Camera Preview or Black Screen Container
            _isCameraPermissionGranted
                ? _isCameraInitialized
                      ? SizedBox.expand(
                          child: Stack(
                            children: [
                              // Camera Preview
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: CameraPreview(controller),
                              ),

                              // Blurred overlay with guided frame
                              CameraFrameScan(sideScan: 'Kanan'),
                            ],
                          ),
                        )
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Colors.black,
                        )
                : SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text('Camera permission is required to scan.'),
                    ),
                  ),

            // Bottom Blue Container
            // Bottom Button Row
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                // color: Colors.amber,
                padding: EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        toggleFlash();
                      },
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: Center(
                          child: Icon(
                            _isFlashOn
                                ? FluentSystemIcons.ic_fluent_flash_on_regular
                                : FluentSystemIcons.ic_fluent_flash_off_regular,
                            color: primaryBlueColor,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        takePicture();
                        print('take picture');
                      },
                      child: Container(
                        width: 90, // Ukuran lebih besar untuk border
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                          border: Border.all(
                            width: 1,
                            color: primaryBlueColor,
                          ), // Warna border
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            5,
                          ), // Jarak antara border dan isi
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white, // Warna isi
                            ),
                            child: Center(
                              child: Icon(
                                FluentSystemIcons.ic_fluent_camera_regular,
                                size: 40,
                                color: primaryBlueColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: switchCamera,
                      child: Container(
                        width: 54,
                        height: 54,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        child: Center(
                          child: Icon(
                            FluentSystemIcons.ic_fluent_camera_switch_regular,
                            color: primaryBlueColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
