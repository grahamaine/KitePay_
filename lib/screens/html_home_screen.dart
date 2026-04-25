import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:kitepay_app_2026/screens/send_screen.dart';
import 'package:kitepay_app_2026/widgets/balance_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Dark-themed HTML Quick Actions
  static const String _htmlQuickActions = '''
    <div style="font-family: sans-serif; padding: 10px 0;">
      <h3 style="color: #94a3b8; font-size: 16px; margin-bottom: 12px;">Quick Actions (Web3 Mode)</h3>
      <div style="display: flex; gap: 15px;">
        <a href="kitepay://send" style="text-decoration: none; flex: 1;">
          <div style="background: #1e293b; padding: 18px; border-radius: 16px; text-align: center; border: 1px solid #334155; color: white;">
            <b style="color: #fbbf24;">Send</b>
          </div>
        </a>
        <a href="kitepay://receive" style="text-decoration: none; flex: 1;">
          <div style="background: #1e293b; padding: 18px; border-radius: 16px; text-align: center; border: 1px solid #334155; color: white;">
            <b style="color: #34d399;">Receive</b>
          </div>
        </a>
      </div>
    </div>
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Slate 900
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/logo.png',
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.account_balance_wallet,
              color: Colors.blueAccent,
            ),
          ),
        ),
        title: const Text(
          "KitePay",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // 1. MAIN BALANCE CARD
            BalanceCard(),

            const SizedBox(height: 20),

            // 2. HTML QUICK ACTIONS (Hybrid Bridge)
            HtmlWidget(
              _htmlQuickActions,
              onTapUrl: (url) {
                dev.log("HTML Action Triggered: $url");
                if (url == "kitepay://send") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SendScreen()),
                  );
                }
                return true;
              },
            ),

            const SizedBox(height: 30),

            // 3. PORTFOLIO ANALYSIS
            const Text(
              "Portfolio Analysis",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildAnalysisCard(
                  "Weekly Growth",
                  "+12.5%",
                  Icons.trending_up,
                  Colors.greenAccent,
                ),
                const SizedBox(width: 15),
                _buildAnalysisCard(
                  "Assets",
                  "4 Tokens",
                  Icons.pie_chart,
                  Colors.blueAccent,
                ),
              ],
            ),

            const SizedBox(height: 30),

            // 4. MY ASSETS SECTION
            const Text(
              "My Assets",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _assetTile("Kite", "KITE", "1.0000", "\$4,250.00", "+2.5%"),
            _assetTile("Ethereum", "ETH", "0.4500", "\$1,200.40", "-1.2%"),

            const SizedBox(height: 30),

            // 5. RECENT ACTIVITY
            const Text(
              "Recent Activity",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            _activityTile(
              "Sent to 0x4b2...",
              "- 0.05 KITE",
              "Oct 24, 2026",
              Icons.outbond,
              Colors.redAccent,
            ),
            _activityTile(
              "Received from Faucet",
              "+ 1.00 KITE",
              "Oct 22, 2026",
              Icons.download,
              Colors.greenAccent,
            ),

            const SizedBox(height: 20),
            _nativeButton(Icons.history, "View Full History"),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildAnalysisCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(color: Colors.white60, fontSize: 12),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _assetTile(
    String name,
    String symbol,
    String amount,
    String value,
    String change,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.blueAccent.withValues(alpha: 0.1),
            child: Text(
              symbol[0],
              style: const TextStyle(color: Colors.blueAccent),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  change,
                  style: TextStyle(
                    color: change.startsWith('+')
                        ? Colors.greenAccent
                        : Colors.redAccent,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "$amount $symbol",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _activityTile(
    String title,
    String amount,
    String date,
    IconData icon,
    Color color,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        date,
        style: const TextStyle(color: Colors.white54, fontSize: 12),
      ),
      trailing: Text(
        amount,
        style: TextStyle(
          color: amount.startsWith('+') ? Colors.greenAccent : Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _nativeButton(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue.withValues(alpha: 0.1),
            child: Icon(icon, color: Colors.blue[400], size: 18),
          ),
          const SizedBox(width: 15),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Colors.white24),
        ],
      ),
    );
  }
}
