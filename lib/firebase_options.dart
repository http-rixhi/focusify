// BSD 3-Clause License
// Copyright (c) 2023, Rishi Raj & Pushpendra Baswalh


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
    apiKey: 'AIzaSyC84tNKZDGSemB7tZb8NUEdi0UcFnGooq8',
    appId: '1:268199927256:web:77fd92252f64010e3066ad',
    messagingSenderId: '268199927256',
    projectId: 'focusio-52ec3',
    authDomain: 'focusio-52ec3.firebaseapp.com',
    storageBucket: 'focusio-52ec3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAySygTzg78L1Cms5SMsYeA2QQNPG2ZAxc',
    appId: '1:268199927256:android:b13dfeb5d137d5873066ad',
    messagingSenderId: '268199927256',
    projectId: 'focusio-52ec3',
    storageBucket: 'focusio-52ec3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCYeHZfbS_RCcpYm_qcZCQsWFNSfcinnpI',
    appId: '1:268199927256:ios:3b9a8b004c5265ce3066ad',
    messagingSenderId: '268199927256',
    projectId: 'focusio-52ec3',
    storageBucket: 'focusio-52ec3.appspot.com',
    iosBundleId: 'com.example.focusio',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCYeHZfbS_RCcpYm_qcZCQsWFNSfcinnpI',
    appId: '1:268199927256:ios:834bcec445528a9d3066ad',
    messagingSenderId: '268199927256',
    projectId: 'focusio-52ec3',
    storageBucket: 'focusio-52ec3.appspot.com',
    iosBundleId: 'com.example.focusio.RunnerTests',
  );
}
