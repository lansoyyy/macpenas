import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:macpenas/screens/auth/landing_page.dart';
import 'package:macpenas/screens/auth/login_screen.dart';
import 'package:macpenas/screens/home_screen.dart';
import 'package:macpenas/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          authDomain: 'macpenas-2f88f.firebaseapp.com',
          apiKey: "AIzaSyCv_OPklX8HCIUW1jO86AwH0UQVfvafPLc",
          appId: "1:609346627661:web:10ca1a460dd8d5db9c5404",
          messagingSenderId: "609346627661",
          projectId: "macpenas-2f88f",
          storageBucket: "macpenas-2f88f.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Macpenas',
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomeScreen();
            } else {
              return const LandingScreen();
            }
          }),
      initialRoute: '/landingscreen',
      routes: {
        Routes().loginscreen: (context) => const LoginScreen(),
        Routes().homescreen: (context) => const HomeScreen(),
        Routes().landingscreen: (context) => const LandingScreen(),
      },
    );
  }
}
