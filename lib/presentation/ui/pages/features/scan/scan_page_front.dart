import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:skinisense/config/routes/Route.dart';
import 'package:skinisense/domain/services/sharedPreferences-services.dart';
import 'package:skinisense/presentation/ui/widget/alertdialog_widget.dart';
import 'package:skinisense/presentation/ui/widget/camera_frame_scan.dart';

late List<CameraDescription> _cameras; // List camera use

class ScanPageFront extends StatefulWidget {
  const ScanPageFront({super.key});

  @override
  State<ScanPageFront> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPageFront> {
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
    controller = CameraController(cameraDescription, ResolutionPreset.max,
        enableAudio: false);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isCameraInitialized = true;
      });
    }).catchError((Object e) {
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
      XFile picture = await controller.takePicture();
      SharedPreferencesService().saveString('scan_face_front', picture.path);
      print('Picture saved to ${picture.path}');
      Navigator.of(context).pushNamed(routeScanFrontPreview);
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
      body: SafeArea(
        child: Column(
          children: [
            // Camera Preview or Black Screen Container
            _isCameraPermissionGranted
                ? _isCameraInitialized
                    ? Stack(
                        children: [
                          // Camera Preview
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height -
                                MediaQuery.of(context).size.height * 0.15,
                            child: CameraPreview(controller),
                          ),

                          // Blurred overlay with guided frame
                          CameraFrameScan(
                            sideScan: 'Depan',
                          )
                        ],
                      )
                    : Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).size.height * 0.15,
                        color: Colors.black,
                      )
                : Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).size.height * 0.15,
                    child: Center(
                      child: Text('Camera permission is required to scan.'),
                    ),
                  ),

            // Bottom Blue Container
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.blue,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        toggleFlash();
                      },
                      child: Icon(
                        _isFlashOn
                            ? FluentSystemIcons.ic_fluent_flash_on_regular
                            : FluentSystemIcons.ic_fluent_flash_off_regular,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        takePicture();
                        print('take picture');
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: switchCamera,
                      child: Icon(
                        FluentSystemIcons.ic_fluent_camera_switch_regular,
                        color: Colors.white,
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
