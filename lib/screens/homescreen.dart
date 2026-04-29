import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const KitePayApp());

class KitePayApp extends StatelessWidget {
  const KitePayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KitePay dApp',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0A0C),
      ),
      home: const KitePayDashboard(),
    );
  }
}

class KitePayDashboard extends StatefulWidget {
  const KitePayDashboard({super.key});

  @override
  State<KitePayDashboard> createState() => _KitePayDashboardState();
}

class _KitePayDashboardState extends State<KitePayDashboard> {
  // --- Agent & Identity State (Merged from snippet 1) ---
  final String agentId = "agent_019dd9ae";
  final String walletAddr = "0xFFeC82F9830f70fD9c978E1264472B08EbB0115c";
  
  bool _isSyncing = false;
  bool _agentActive = false;
  String _sessionLimit = "0.00 USDC";

  // --- Theme Colors (Merged from snippet 2) ---
  static const Color bgColor = Color(0xFF0A0A0C);
  static const Color surfaceColor = Color(0xFF111115);
  static const Color accentColor = Color(0xFF6C5CE7); // Kite Purple
  static const Color accent2Color = Color(0xFFA29BFE); // Light Lavender
  static const Color mutedColor = Color(0xFF6B6A7A);

  String _shortAddr(String addr) =>
      "${addr.substring(0, 6)}...${addr.substring(addr.length - 4)}";

  Future<void> _syncWithKitePassport() async {
    setState(() => _isSyncing = true);
    
    // Simulating: kpass user sessions --status active (from CLI 2026 logic)
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isSyncing = false;
      _agentActive = true;
      _sessionLimit = "2.00 USDC"; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  _buildHeroPortfolio(),
                  const SizedBox(height: 24),
                  _buildAgentDeploymentSection(),
                  const SizedBox(height: 24),
                  _buildMainAssetCard(),
                  const SizedBox(height: 32),
                  _buildQuickActions(),
                  const SizedBox(height: 32),
                  _buildActivityFeed(),
                ],
              ),
            ),
            _buildBottomNavbar(),
          ],
        ),
      ),
    );
  }

  // Header incorporating the branding from snippet 1 & style of snippet 2
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 46, height: 46,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(colors: [accentColor, accent2Color]),
                ),
                child: const Center(
                  child: Text("AK", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("DASHBOARD", 
                    style: TextStyle(color: mutedColor, fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
                  Text(_shortAddr(walletAddr), 
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontFamily: 'monospace')),
                ],
              )
            ],
          ),
          // Branded Logo with status indicator
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _agentActive ? Colors.greenAccent.withOpacity(0.5) : Colors.white10,
                width: 2
              ),
              image: const DecorationImage(
                image: AssetImage('assets/KitePay_Dapp.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroPortfolio() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("PORTFOLIO VALUE", style: TextStyle(color: mutedColor, fontSize: 11)),
              const SizedBox(height: 8),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(text: "\$", style: TextStyle(color: accent2Color, fontSize: 24)),
                    TextSpan(text: "12,450", style: TextStyle(color: Colors.white, fontSize: 44, fontWeight: FontWeight.bold)),
                    TextSpan(text: ".82", style: TextStyle(color: mutedColor, fontSize: 24)),
                  ],
                ),
              ),
            ],
          ),
          _buildDonutChart(),
        ],
      ),
    );
  }

  Widget _buildAgentDeploymentSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: _agentActive
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.verified_user, color: Colors.green, size: 20),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Agent Authorized", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      Text("Session Limit: $_sessionLimit", style: const TextStyle(color: Colors.white38, fontSize: 11)),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.shield_outlined, color: Colors.green, size: 18),
                ],
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                elevation: 0,
              ),
              onPressed: _isSyncing ? null : _syncWithKitePassport,
              child: _isSyncing
                  ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text("SYNC WITH KITE PASSPORT", 
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            ),
    );
  }

  Widget _buildMainAssetCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF0F3460)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("PRIMARY WALLET", style: TextStyle(color: Colors.white54, fontSize: 10, letterSpacing: 1.5)),
          SizedBox(height: 20),
          Text("0.1482 BTC", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
          Text("≈ \$9,841.20 USD", style: TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _actionItem("Send", Icons.north_east, Colors.blueAccent),
          _actionItem("Receive", Icons.south_west, Colors.greenAccent),
          _actionItem("Swap", Icons.swap_horiz, Colors.orangeAccent),
          _actionItem("Vault", Icons.lock_outline, accent2Color),
        ],
      ),
    );
  }

  Widget _actionItem(String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          width: 64, height: 64,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1), 
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.05))
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(color: mutedColor, fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildActivityFeed() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("RECENT ACTIVITY", style: TextStyle(color: mutedColor, fontSize: 10, letterSpacing: 1.5, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _activityRow("Agent Registered", agentId.substring(0, 18) + "...", "Success", Icons.auto_awesome),
          _activityRow("Wallet Linked", "Kite Chain Mainnet", "Verified", Icons.link),
        ],
      ),
    );
  }

  Widget _activityRow(String title, String sub, String status, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: accent2Color, size: 20),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
              Text(sub, style: const TextStyle(color: mutedColor, fontSize: 12)),
            ],
          ),
          const Spacer(),
          Text(status, style: const TextStyle(color: Colors.white38, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildDonutChart() {
    return SizedBox(
      width: 75, height: 75,
      child: CustomPaint(
        painter: DonutPainter(segment1: 0.7, segment2: 0.2),
        child: const Center(
          child: Text("3", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        ),
      ),
    );
  }

  Widget _buildBottomNavbar() {
    return Positioned(
      bottom: 0, left: 0, right: 0,
      child: Container(
        height: 95,
        padding: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: surfaceColor.withOpacity(0.98),
          border: const Border(top: BorderSide(color: Colors.white10)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.grid_view_rounded, color: accent2Color, size: 28),
            Icon(Icons.analytics_outlined, color: mutedColor, size: 28),
            Icon(Icons.center_focus_weak, color: mutedColor, size: 28),
            Icon(Icons.settings_input_component_outlined, color: mutedColor, size: 28),
          ],
        ),
      ),
    );
  }
}

class DonutPainter extends CustomPainter {
  final double segment1;
  final double segment2;

  DonutPainter({required this.segment1, required this.segment2});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 9
      ..strokeCap = StrokeCap.round;

    // Background track
    paint.color = const Color(0xFF1F1F28);
    canvas.drawCircle(center, radius - 5, paint);

    // Segment 1 (Kite Purple)
    paint.color = const Color(0xFF6C5CE7);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 5), -math.pi / 2, 2 * math.pi * segment1, false, paint);

    // Segment 2 (Lavender)
    paint.color = const Color(0xFFA29BFE);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 5), 
        (-math.pi / 2) + (2 * math.pi * segment1), 2 * math.pi * segment2, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}