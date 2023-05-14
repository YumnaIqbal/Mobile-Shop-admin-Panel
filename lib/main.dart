import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobileshop_admin_portal/authentication/login_screen.dart';
import 'package:mobileshop_admin_portal/main_screen/home_screen.dart';

Future<void> main() async {
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDJTslI8wBIzCt2-OgKmshtsRiL3mCXuKM",
          authDomain: "mobileseller-app.firebaseapp.com",
          projectId: "mobileseller-app",
          storageBucket: "mobileseller-app.appspot.com",
          messagingSenderId: "310230187294",
          appId: "1:310230187294:web:73fc6fb5df9090d8dc9d0f"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Web Portal',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: FirebaseAuth.instance.currentUser == null ? LoginScreen() : HomeScreen(),
    );
  }
}

