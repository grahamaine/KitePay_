import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:kitepay_app_2026/widgets/balance_card.dart'; // Error 1 Fixed

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String _htmlQuickActions = '''
    <div style="font-family: sans-serif; padding: 10px 0;">
      <h3 style="color: #1e293b;">Quick Actions</h3>
      <div style="display: flex; gap: 15px;">
        <a href="kitepay://send" style="text-decoration: none; flex: 1;">
          <div style="background: white; padding: 20px; border-radius: 16px; text-align: center; border: 1px solid #e2e8f0;">
            <b>Send</b>
          </div>
        </a>
        <a href="kitepay://receive" style="text-decoration: none; flex: 1;">
          <div style="background: white; padding: 20px; border-radius: 16px; text-align: center; border: 1px solid #e2e8f0;">
            <b>Receive</b>
          </div>
        </a>
      </div>
    </div>
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(title: const Text("KitePay"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            BalanceCard(), // Error 2 Fixed
            const SizedBox(height: 10),
            HtmlWidget(
              _htmlQuickActions,
              onTapUrl: (url) {
                dev.log("Action: $url");
                return true;
              },
            ),
            const SizedBox(height: 20),
            _nativeButton(Icons.history, "Activity"),
          ],
        ),
      ),
    );
  }

  Widget _nativeButton(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 25,
          // Error 3 Fixed
          backgroundColor: Colors.blue.withValues(alpha: 0.1),
          child: Icon(icon, color: Colors.blue[800]),
        ),
        Text(label),
      ],
    );
  }
}
