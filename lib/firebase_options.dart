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
    apiKey: 'AIzaSyBGMGpzU7dcipkXaSEukVApxEADMAwmI3k',
    appId: '1:896121137653:web:8e8fcfa77c1b0a58d258bc',
    messagingSenderId: '896121137653',
    projectId: 'live-c9d1f',
    authDomain: 'live-c9d1f.firebaseapp.com',
    storageBucket: 'live-c9d1f.appspot.com',
    measurementId: 'G-RDJX1L9XV1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCr7UuqBsUFAmLRxcqpDRolwLeYZ9svq6w',
    appId: '1:896121137653:android:3481f14dd457bd57d258bc',
    messagingSenderId: '896121137653',
    projectId: 'live-c9d1f',
    storageBucket: 'live-c9d1f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2AbPg1b3jz2yauxX2R7XwfSRoYKzxSmc',
    appId: '1:896121137653:ios:c009bdae34900e03d258bc',
    messagingSenderId: '896121137653',
    projectId: 'live-c9d1f',
    storageBucket: 'live-c9d1f.appspot.com',
    iosBundleId: 'com.example.live',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA2AbPg1b3jz2yauxX2R7XwfSRoYKzxSmc',
    appId: '1:896121137653:ios:c009bdae34900e03d258bc',
    messagingSenderId: '896121137653',
    projectId: 'live-c9d1f',
    storageBucket: 'live-c9d1f.appspot.com',
    iosBundleId: 'com.example.live',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBGMGpzU7dcipkXaSEukVApxEADMAwmI3k',
    appId: '1:896121137653:web:9f1f5b25681372c2d258bc',
    messagingSenderId: '896121137653',
    projectId: 'live-c9d1f',
    authDomain: 'live-c9d1f.firebaseapp.com',
    storageBucket: 'live-c9d1f.appspot.com',
    measurementId: 'G-BTLYL6J4JK',
  );
}
