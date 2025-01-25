import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class FirebaseOptionsAndroid {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJshzF1hxqU_czp5XIijzxuuoowHXFkaY', 
    appId: '1:675583055979:android:81df841df7b9ebda3f792e', 
    messagingSenderId: '675583055979', 
    projectId: 'suvidha-2901f',
    storageBucket: 'suvidha-2901f.firebasestorage.app', 
    androidClientId: '1:675583055979:android:81df841df7b9ebda3f792e', 
  );
}
