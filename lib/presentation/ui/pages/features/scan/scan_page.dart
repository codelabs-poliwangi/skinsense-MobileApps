import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart'; // Import permission_handler
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:skinisense/presentation/ui/widget/camera_frame_scan.dart';

late List<CameraDescription> _cameras;

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late CameraController controller;
  bool _isCameraPermissionGranted = false;
  bool _isCameraInitialized = false;
  int _selectedCameraIndex = 0; // Track current camera

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
      // Handle case if the user denies the permission
      print('Camera permission denied');
    } else if (status.isPermanentlyDenied) {
      // Redirect user to app settings if permission is permanently denied
      await openAppSettings();
    }
  }

  // Function to load available cameras and initialize the first one
  Future<void> _initializeCameras() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isNotEmpty) {
        _initializeCamera(_cameras[_selectedCameraIndex]);
      } else {
        print('No cameras available');
      }
    } catch (e) {
      print('Error loading cameras: $e');
    }
  }

  // Function to initialize the camera
  void _initializeCamera(CameraDescription cameraDescription) {
    controller = CameraController(cameraDescription, ResolutionPreset.max);
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
  Future<void> takePicture() async {
    if (!controller.value.isInitialized) {
      print('Error: Camera is not initialized');
      return null;
    }

    try {
      XFile picture = await controller.takePicture();
      print('Picture saved to ${picture.path}');
    } catch (e) {
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
                            height: MediaQuery.sizeOf(context).height -
                                MediaQuery.sizeOf(context).height * 0.15,
                            child: CameraPreview(controller),
                          ),

                          // Blurred overlay with guided frame
                          CameraFrameScan()
                        ],
                      )
                    : Container(
                        width: double.infinity,
                        height: MediaQuery.sizeOf(context).height -
                            MediaQuery.sizeOf(context).height * 0.15,
                        color: Colors.black,
                      )
                : Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height -
                        MediaQuery.sizeOf(context).height * 0.15,
                    child: Center(
                      child: Text('Camera permission is required to scan.'),
                    ),
                  ),

            // Bottom Blue Container
            Expanded(
              child: Container(
                // height: MediaQuery.sizeOf(context).height * 0.5,
                width: double.infinity,
                color: Colors.blue,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox.shrink(),
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
