import 'package:flutter/material.dart';
import '../widgets/token_list.dart';
import '../widgets/action_buttons.dart';
import '../widgets/transaction_history.dart';
import '../widgets/html_dashboard_renderer.dart';
import '../widgets/portfolio_card.dart'; // NEW IMPORT

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "KitePay Dashboard", 
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          
          // NEW: Portfolio Data Widget
          const PortfolioCard(totalBalance: "5,820.12", changePercentage: "+5.2%"),
          
          const SizedBox(height: 40),
          const TokenListWidget(),
          const SizedBox(height: 40),
          const ActionButtons(),
          const SizedBox(height: 40),
          const TransactionHistory(),
          const SizedBox(height: 40),
          const HtmlDashboardRenderer(),
        ],
      ),
    );
  }
}