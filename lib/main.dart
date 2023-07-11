import 'package:flutter/material.dart';
import 'package:macpenas/screens/home_screen.dart';
import 'package:macpenas/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Macpenas',
      home: const HomeScreen(),
      initialRoute: '/homescreen',
      routes: {Routes().homescreen: (context) => const HomeScreen()},
    );
  }
}
