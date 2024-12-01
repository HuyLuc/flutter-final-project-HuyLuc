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
        return windows;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDKnKFeX_eZUlhFR2LFQrx_VdaWRrRFCVs',
    appId: '1:1037602221377:web:9a703f86cd4da48b6345c0',
    messagingSenderId: '1037602221377',
    projectId: 'finalprojectflutter-2121f',
    authDomain: 'finalprojectflutter-2121f.firebaseapp.com',
    storageBucket: 'finalprojectflutter-2121f.firebasestorage.app',
    measurementId: 'G-EWGJESDZ4T',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3qf1xu7UXlLcrAD4PlFz9dcFNp554Gcs',
    appId: '1:1037602221377:android:f792ee68e01e09a06345c0',
    messagingSenderId: '1037602221377',
    projectId: 'finalprojectflutter-2121f',
    storageBucket: 'finalprojectflutter-2121f.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCMTnMCJyPAlra5Vvy3zaqDCto57cuxaeE',
    appId: '1:1037602221377:ios:135a75af2c9802d96345c0',
    messagingSenderId: '1037602221377',
    projectId: 'finalprojectflutter-2121f',
    storageBucket: 'finalprojectflutter-2121f.firebasestorage.app',
    iosBundleId: 'com.example.flutterProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDKnKFeX_eZUlhFR2LFQrx_VdaWRrRFCVs',
    appId: '1:1037602221377:web:a31ae3d3bf1a51d76345c0',
    messagingSenderId: '1037602221377',
    projectId: 'finalprojectflutter-2121f',
    authDomain: 'finalprojectflutter-2121f.firebaseapp.com',
    storageBucket: 'finalprojectflutter-2121f.firebasestorage.app',
    measurementId: 'G-XSDQGMWXK5',
  );
}
