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
    apiKey: 'AIzaSyBLHSdufs_GNuzfwwDEn6Of08mzhPNfMAM',
    appId: '1:907195909683:web:75a591aaddda676a704546',
    messagingSenderId: '907195909683',
    projectId: 'livestreaming-91895',
    authDomain: 'livestreaming-91895.firebaseapp.com',
    storageBucket: 'livestreaming-91895.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAjiV_qY2kGm6voqYUEhw5rOPnt5M69Fv4',
    appId: '1:907195909683:ios:f30c352dbac62a7e704546',
    messagingSenderId: '907195909683',
    projectId: 'livestreaming-91895',
    storageBucket: 'livestreaming-91895.appspot.com',
    iosBundleId: 'com.example.ilive',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBLHSdufs_GNuzfwwDEn6Of08mzhPNfMAM',
    appId: '1:907195909683:web:802e4d6201c63ecc704546',
    messagingSenderId: '907195909683',
    projectId: 'livestreaming-91895',
    authDomain: 'livestreaming-91895.firebaseapp.com',
    storageBucket: 'livestreaming-91895.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAjiV_qY2kGm6voqYUEhw5rOPnt5M69Fv4',
    appId: '1:907195909683:ios:f30c352dbac62a7e704546',
    messagingSenderId: '907195909683',
    projectId: 'livestreaming-91895',
    storageBucket: 'livestreaming-91895.appspot.com',
    iosBundleId: 'com.example.ilive',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA6Pcoj9cYaoE1Fj9kHVFgxe_elMHUXC3s',
    appId: '1:907195909683:android:bd6b934252fa6231704546',
    messagingSenderId: '907195909683',
    projectId: 'livestreaming-91895',
    storageBucket: 'livestreaming-91895.appspot.com',
  );

}