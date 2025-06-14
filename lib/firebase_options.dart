// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCGLSticuUPY-NRQwVIJDSZ2VjN4BJ2Y88',
    appId: '1:18665434995:android:b574b380e9df56c66d9f06',
    messagingSenderId: '18665434995',
    projectId: 'skinisense-2a791',
    storageBucket: 'skinisense-2a791.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAfL3cg0mkP2mj4aHKW8r08r1hRRwkZ73g',
    appId: '1:18665434995:ios:2d8ff15063f0ae266d9f06',
    messagingSenderId: '18665434995',
    projectId: 'skinisense-2a791',
    storageBucket: 'skinisense-2a791.firebasestorage.app',
    androidClientId: '18665434995-mn7g5agt7sj27p845ttomu66nqsfkvbu.apps.googleusercontent.com',
    iosClientId: '18665434995-57umnkgapk053lkrrnlu8buplv9ss3ll.apps.googleusercontent.com',
    iosBundleId: 'com.example.skinisense',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBKNoxsQj4NJtWqWY57t7m20G7d0_MT1no',
    appId: '1:18665434995:web:4a055a67d0cdc7e46d9f06',
    messagingSenderId: '18665434995',
    projectId: 'skinisense-2a791',
    authDomain: 'skinisense-2a791.firebaseapp.com',
    storageBucket: 'skinisense-2a791.firebasestorage.app',
    measurementId: 'G-GD4S75T9T1',
  );

}