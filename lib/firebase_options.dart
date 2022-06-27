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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdeMQhg32VnIBAjkTFz51lEGOrG7xKoOc',
    appId: '1:818856912556:android:8d01dd517d665da6a9e109',
    messagingSenderId: '818856912556',
    projectId: 'mad-lab-19072',
    storageBucket: 'mad-lab-19072.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCR5AKEkcrANcAXjmqFzbr1ansU2IpyG90',
    appId: '1:818856912556:ios:136bdec8220e1a0da9e109',
    messagingSenderId: '818856912556',
    projectId: 'mad-lab-19072',
    storageBucket: 'mad-lab-19072.appspot.com',
    androidClientId: '818856912556-9ojqlmhu47iqjq5ge76a2shuaq268m8m.apps.googleusercontent.com',
    iosClientId: '818856912556-g0dfrn7cqdbjb2p674e6tdt5n0d99q5o.apps.googleusercontent.com',
    iosBundleId: 'com.example.pwdmgr',
  );
}