import 'package:flutter/material.dart';
import 'homescreen.dart'; // Import your UI file

void main() {
  runApp(const KitePayApp());
}

class KitePayApp extends StatelessWidget {
  const KitePayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0C),
      ),
      home: const HomeScreen(), // Tells the app to start here
    );
  }
}