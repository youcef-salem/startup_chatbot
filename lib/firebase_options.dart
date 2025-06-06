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
    apiKey: 'AIzaSyDw0r0VXgEq_aovq8lDf9bs9EIwtYWhdro',
    appId: '1:843360209866:web:f2e7a837f0153b6a6fdd33',
    messagingSenderId: '843360209866',
    projectId: 'startupchatbot-65ee0',
    authDomain: 'startupchatbot-65ee0.firebaseapp.com',
    storageBucket: 'startupchatbot-65ee0.firebasestorage.app',
    measurementId: 'G-2H4025E6F2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC1_1hxSLWsHDnTRjXGBKfp0Duh97kIBUU',
    appId: '1:843360209866:android:51344b71e1bd40716fdd33',
    messagingSenderId: '843360209866',
    projectId: 'startupchatbot-65ee0',
    storageBucket: 'startupchatbot-65ee0.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAZyokQoj0d7B_PaluaOyGj2wuqCV-_E68',
    appId: '1:843360209866:ios:7abd3aebb5c245ed6fdd33',
    messagingSenderId: '843360209866',
    projectId: 'startupchatbot-65ee0',
    storageBucket: 'startupchatbot-65ee0.firebasestorage.app',
    iosClientId: '843360209866-6b3jlgufp3ve273ouksijntmbb22vh1h.apps.googleusercontent.com',
    iosBundleId: 'com.example.startupChatbot',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAZyokQoj0d7B_PaluaOyGj2wuqCV-_E68',
    appId: '1:843360209866:ios:7abd3aebb5c245ed6fdd33',
    messagingSenderId: '843360209866',
    projectId: 'startupchatbot-65ee0',
    storageBucket: 'startupchatbot-65ee0.firebasestorage.app',
    iosClientId: '843360209866-6b3jlgufp3ve273ouksijntmbb22vh1h.apps.googleusercontent.com',
    iosBundleId: 'com.example.startupChatbot',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDw0r0VXgEq_aovq8lDf9bs9EIwtYWhdro',
    appId: '1:843360209866:web:9f433ef2a867a6426fdd33',
    messagingSenderId: '843360209866',
    projectId: 'startupchatbot-65ee0',
    authDomain: 'startupchatbot-65ee0.firebaseapp.com',
    storageBucket: 'startupchatbot-65ee0.firebasestorage.app',
    measurementId: 'G-BJPGP5PY0F',
  );

}