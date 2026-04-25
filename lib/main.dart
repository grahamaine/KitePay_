import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart'; // Import your dashboard

void main() {
  runApp(const KitePayApp());
}

class KitePayApp extends StatelessWidget {
  const KitePayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KitePay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueAccent,
      ),
      // CHANGE THIS LINE:
      home: const DashboardScreen(), 
    );
  }
}
