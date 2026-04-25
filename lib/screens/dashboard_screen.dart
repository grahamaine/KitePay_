import 'package:flutter/material.dart';

// Current Widgets
import '../widgets/token_list.dart';
import '../widgets/action_buttons.dart';
import '../widgets/transaction_history.dart';

// The New HTML Widget
import '../widgets/html_dashboard_renderer.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Added scrollview to prevent overflow
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Dashboard Overview", 
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 30),
          
          // Native Flutter Widgets
          const TokenListWidget(),
          const SizedBox(height: 40),
          const ActionButtons(),
          const SizedBox(height: 40),
          const TransactionHistory(),
          const SizedBox(height: 40),
          
          // Your HTML Renderer Section
          const Text(
            "Analytics & Web Content", 
            style: TextStyle(fontSize: 18, color: Colors.white70),
          ),
          const SizedBox(height: 16),
          const HtmlDashboardRenderer(), 
        ],
      ),
    );
  }
}