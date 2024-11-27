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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBYcvgDTR1wLqyXy2BzyAP7VZe9ljokgRA',
    appId: '1:748109815411:web:f50f1b606c7e8a26b6d406',
    messagingSenderId: '748109815411',
    projectId: 'kultura-app-group13',
    authDomain: 'kultura-app-group13.firebaseapp.com',
    storageBucket: 'kultura-app-group13.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBAku7gwanS4rNKMZfmvP1q_T2jLx98kJw',
    appId: '1:748109815411:android:93a43eed2ecea267b6d406',
    messagingSenderId: '748109815411',
    projectId: 'kultura-app-group13',
    storageBucket: 'kultura-app-group13.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBuCGIZYOarNGfw1Y4qTn8TW0qcLVef3AU',
    appId: '1:748109815411:ios:fca380cb61ef4bd1b6d406',
    messagingSenderId: '748109815411',
    projectId: 'kultura-app-group13',
    storageBucket: 'kultura-app-group13.firebasestorage.app',
    iosBundleId: 'com.example.kultura',
  );
}
