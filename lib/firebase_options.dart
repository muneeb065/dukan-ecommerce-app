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
    apiKey: 'AIzaSyBbEin-PbQMEnj93HtNBACm3OYZR9-qKK4',
    appId: '1:885793696434:web:ab27fcec5aa22a45c2f7ab',
    messagingSenderId: '885793696434',
    projectId: 'markazapp-2285f',
    authDomain: 'markazapp-2285f.firebaseapp.com',
    storageBucket: 'markazapp-2285f.appspot.com',
    measurementId: 'G-K2ZNT9PN7L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD828SOUiAAA4FEvB3r-XglVe1FN7UY1lk',
    appId: '1:885793696434:android:3e330f12c6a71292c2f7ab',
    messagingSenderId: '885793696434',
    projectId: 'markazapp-2285f',
    storageBucket: 'markazapp-2285f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDDwzobmNlc7YwOk2UCXCnasj0WNS8bSvU',
    appId: '1:885793696434:ios:0c025e3a21e6efb4c2f7ab',
    messagingSenderId: '885793696434',
    projectId: 'markazapp-2285f',
    storageBucket: 'markazapp-2285f.appspot.com',
    iosClientId: '885793696434-pi8v9jgp4mfk2s39ti3qcjcd94olgqa4.apps.googleusercontent.com',
    iosBundleId: 'com.example.dukan',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDDwzobmNlc7YwOk2UCXCnasj0WNS8bSvU',
    appId: '1:885793696434:ios:a33620ab428f05c5c2f7ab',
    messagingSenderId: '885793696434',
    projectId: 'markazapp-2285f',
    storageBucket: 'markazapp-2285f.appspot.com',
    iosClientId: '885793696434-0pceee4ugccj2qj483ohq2cnrbl68c6f.apps.googleusercontent.com',
    iosBundleId: 'com.example.dukan.RunnerTests',
  );
}
