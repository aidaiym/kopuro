// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAJge6N50WlxLEZdcWnlS_nbYBweSLe0_g',
    appId: '1:433828119900:web:24aac8f2b552ca2b102d99',
    messagingSenderId: '433828119900',
    projectId: 'kopuro-5fe2a',
    authDomain: 'kopuro-5fe2a.firebaseapp.com',
    storageBucket: 'kopuro-5fe2a.appspot.com',
    measurementId: 'G-2YWF4JJ592',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB5SmRhkIGjlAoemhOWuUw8P_Y3qD27fTc',
    appId: '1:433828119900:android:4a10495953145558102d99',
    messagingSenderId: '433828119900',
    projectId: 'kopuro-5fe2a',
    storageBucket: 'kopuro-5fe2a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCU3s-0-4ptE4L7mdF4slwRI4CNYxFO4js',
    appId: '1:433828119900:ios:44da6a38713da7a1102d99',
    messagingSenderId: '433828119900',
    projectId: 'kopuro-5fe2a',
    storageBucket: 'kopuro-5fe2a.appspot.com',
    iosBundleId: 'com.example.kopuro',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCU3s-0-4ptE4L7mdF4slwRI4CNYxFO4js',
    appId: '1:433828119900:ios:76fab45f9e5a777b102d99',
    messagingSenderId: '433828119900',
    projectId: 'kopuro-5fe2a',
    storageBucket: 'kopuro-5fe2a.appspot.com',
    iosBundleId: 'com.example.kopuro.RunnerTests',
  );
}
