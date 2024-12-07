import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:gmcweb/Login/userState.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDLq-iNSUPe1zlVI-6gdD1eqogjan5UhN4",
          authDomain: "gmc-95f76.firebaseapp.com",
          projectId: "gmc-95f76",
          storageBucket: "gmc-95f76.appspot.com",
          messagingSenderId: "495285712978",
          appId: "1:495285712978:web:739f64ebb49e9d5abac78b"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//root build entry point
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //home: GmcHome(),
      //home: Login(),
      home: UserState(),
    );
  }
}
