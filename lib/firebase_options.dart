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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyAKjP0a_9DW0vwFm7jpt9q9I1oiQe6KwmU',
    appId: '1:1079383902678:web:6cdde9c41bb15e43a6bc77',
    messagingSenderId: '1079383902678',
    projectId: 'popcornnews-31b43',
    authDomain: 'popcornnews-31b43.firebaseapp.com',
    databaseURL: 'https://popcornnews-31b43-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'popcornnews-31b43.appspot.com',
    measurementId: 'G-Y095VJWC79',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAio13iznTEoylL2rHzs_JedTtWRMCN9SQ',
    appId: '1:1079383902678:ios:4b2b8799a7e8c25ba6bc77',
    messagingSenderId: '1079383902678',
    projectId: 'popcornnews-31b43',
    databaseURL: 'https://popcornnews-31b43-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'popcornnews-31b43.appspot.com',
    androidClientId: '1079383902678-1k6gbdebfjhnvd3ufb11rqumbvfrn2i1.apps.googleusercontent.com',
    iosBundleId: 'com.example.formac',
  );

}