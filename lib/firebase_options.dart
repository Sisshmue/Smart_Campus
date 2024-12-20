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
        return macos;
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
    apiKey: 'AIzaSyCnSyYkRABwnAan12gUXgiBVzG-cDYtYZs',
    appId: '1:752482409998:web:8490cb295e681deb16665f',
    messagingSenderId: '752482409998',
    projectId: 'smartcampus-backend',
    authDomain: 'smartcampus-backend.firebaseapp.com',
    storageBucket: 'smartcampus-backend.firebasestorage.app',
    measurementId: 'G-PD0XFH7N1J',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDs5tRUV7ySHv693eCVJKmB3Fwus5MQOsc',
    appId: '1:752482409998:android:e0678dceca7e5da316665f',
    messagingSenderId: '752482409998',
    projectId: 'smartcampus-backend',
    storageBucket: 'smartcampus-backend.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2yoATcFPMTu2E7Dj_OaUajye8NsvvDKY',
    appId: '1:752482409998:ios:74d025bbf5edce2116665f',
    messagingSenderId: '752482409998',
    projectId: 'smartcampus-backend',
    storageBucket: 'smartcampus-backend.firebasestorage.app',
    iosBundleId: 'com.example.smartCampusMobileApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA2yoATcFPMTu2E7Dj_OaUajye8NsvvDKY',
    appId: '1:752482409998:ios:74d025bbf5edce2116665f',
    messagingSenderId: '752482409998',
    projectId: 'smartcampus-backend',
    storageBucket: 'smartcampus-backend.firebasestorage.app',
    iosBundleId: 'com.example.smartCampusMobileApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCnSyYkRABwnAan12gUXgiBVzG-cDYtYZs',
    appId: '1:752482409998:web:9ebe0d154c775db916665f',
    messagingSenderId: '752482409998',
    projectId: 'smartcampus-backend',
    authDomain: 'smartcampus-backend.firebaseapp.com',
    storageBucket: 'smartcampus-backend.firebasestorage.app',
    measurementId: 'G-8W5SL54BJB',
  );
}
