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



/*    const bool USE_LOCAL_FIREBASE = bool.fromEnvironment('USE_LOCAL_FIREBASE');
    if (USE_LOCAL_FIREBASE) {
      return FirebaseOptions(
        // apiKey: 'AIzaSyB6072DH2fyb9Jqn1VBmx8IxLDOguiQTe8',
        // appId: '1:880029952543:web:eb04ebd667cda2be11c32a',
        // messagingSenderId: '880029952543',
        projectId: 'lazitsapp-8c7fb',
        // authDomain: 'lazitsapp-8c7fb.firebaseapp.com',
        // databaseURL: 'https://lazitsapp-8c7fb.firebaseio.com',
        // storageBucket: 'lazitsapp-8c7fb.appspot.com',
        // measurementId: 'G-SMNFZ3HZTW',
      );
      firebaseFirestoreInstance.settings = const Settings(
        host: 'localhost:8080',
        sslEnabled: false,
        persistenceEnabled: false,
      );
    }*/


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
    apiKey: 'AIzaSyB6072DH2fyb9Jqn1VBmx8IxLDOguiQTe8',
    appId: '1:880029952543:web:eb04ebd667cda2be11c32a',
    messagingSenderId: '880029952543',
    projectId: 'lazitsapp-8c7fb',
    authDomain: 'lazitsapp-8c7fb.firebaseapp.com',
    databaseURL: 'https://lazitsapp-8c7fb.firebaseio.com',
    storageBucket: 'lazitsapp-8c7fb.appspot.com',
    measurementId: 'G-SMNFZ3HZTW',
  );
}
