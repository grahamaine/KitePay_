import 'package:flutter/material.dart';
import 'dart:math' as math;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Agent State
  bool _isDeploying = false;
  bool _agentActive = false;

  // Theme Colors from your CSS
  static const Color bgColor = Color(0xFF0A0A0C);
  static const Color surfaceColor = Color(0xFF111115);
  static const Color surface2Color = Color(0xFF18181F);
  static const Color accentColor = Color(0xFF6C5CE7);
  static const Color accent2Color = Color(0xFFA29BFE);
  static const Color btcColor = Color(0xF7931A);
  static const Color ethColor = Color(0xFF627EEA);
  static const Color usdtColor = Color(0xFF26A17B);
  static const Color mutedColor = Color(0xFF6B6A7A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 120), // Padding for Navbar
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTopbar(),
                  _buildHero(),
                  const SizedBox(height: 24),
                  _buildDeploymentSection(), // Our Agent Logic
                  const SizedBox(height: 24),
                  _buildBTCCard(),
                  const SizedBox(height: 24),
                  _buildQuickActions(),
                  const SizedBox(height: 32),
                  _buildAssetSection(),
                  const SizedBox(height: 32),
                  _buildRecentActivity(),
                ],
              ),
            ),
            _buildNavbar(),
          ],
        ),
      ),
    );
  }

  // ── AGENT DEPLOYMENT COMPONENT ──
  Widget _buildDeploymentSection() {
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
              child: const Row(
                children: [
                  Icon(Icons.verified_user, color: Colors.green, size: 20),
                  SizedBox(width: 12),
                  Text("Kite Passport Agent Active", 
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                ],
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              onPressed: _isDeploying ? null : _handleDeploy,
              child: _isDeploying
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("DEPLOY KITE PASSPORT AGENT", 
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
            ),
    );
  }

  Future<void> _handleDeploy() async {
    setState(() => _isDeploying = true);
    await Future.delayed(const Duration(seconds: 2)); // Simulate Kite API call
    setState(() {
      _isDeploying = false;
      _agentActive = true;
    });
  }

  // ── UI COMPONENTS ──

  Widget _buildTopbar() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 23,
                flexibleConfig: const BoxDecoration(
                  gradient: LinearGradient(colors: [accentColor, Color(0xFF00D2D3)]),
                ),
                child: const Text("AK", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("GOOD MORNING", style: TextStyle(color: mutedColor, fontSize: 10, letterSpacing: 1.5)),
                  Text("Alex Kite", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
          const Icon(Icons.notifications_none, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("TOTAL PORTFOLIO VALUE", style: TextStyle(color: mutedColor, fontSize: 11)),
              const SizedBox(height: 8),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(text: "\$", style: TextStyle(color: accent2Color, fontSize: 24)),
                    TextSpan(text: "12,450", style: TextStyle(color: Colors.white, fontSize: 48, fontWeight: FontWeight.bold)),
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

  Widget _buildDonutChart() {
    return SizedBox(
      width: 80,
      height: 80,
      child: CustomPaint(
        painter: DonutPainter(),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("3", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text("assets", style: TextStyle(color: mutedColor, fontSize: 8)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBTCCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF0F3460)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("BITCOIN WALLET", style: TextStyle(color: Colors.white54, fontSize: 10)),
          SizedBox(height: 20),
          Text("0.14823 BTC", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
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
          _actionItem("Send", "📤", accentColor.withOpacity(0.1)),
          _actionItem("Receive", "📥", Colors.green.withOpacity(0.1)),
          _actionItem("Swap", "🔄", Colors.amber.withOpacity(0.1)),
          _actionItem("Vault", "🔒", accent2Color.withOpacity(0.1)),
        ],
      ),
    );
  }

  Widget _actionItem(String label, String icon, Color color) {
    return Column(
      children: [
        Container(
          width: 60, height: 60,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(18)),
          alignment: Alignment.center,
          child: Text(icon, style: const TextStyle(fontSize: 24)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: mutedColor, fontSize: 12)),
      ],
    );
  }

  Widget _buildAssetSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Your Assets", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text("See all →", style: TextStyle(color: accent2Color, fontSize: 12)),
            ],
          ),
          // Add your Asset List Tiles here...
        ],
      ),
    );
  }

  Widget _buildRecentActivity() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Recent Activity", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          // Add your Activity Rows here...
        ],
      ),
    );
  }

  Widget _buildNavbar() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 90,
        decoration: BoxDecoration(
          color: surfaceColor.withOpacity(0.9),
          border: const Border(top: BorderSide(color: Colors.white10)),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.home_filled, color: accent2Color),
            Icon(Icons.bar_chart, color: mutedColor),
            Icon(Icons.qr_code_scanner, color: mutedColor),
            Icon(Icons.lock_outline, color: mutedColor),
          ],
        ),
      ),
    );
  }
}

// ── CUSTOM DONUT PAINTER ──
class DonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;

    // Background
    paint.color = const Color(0xFF1F1F28);
    canvas.drawCircle(center, radius - 5, paint);

    // BTC Segment (79%)
    paint.color = const Color(0xF7931A);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 5), -math.pi / 2, 2 * math.pi * 0.79, false, paint);

    // ETH Segment (17%)
    paint.color = const Color(0xFF627EEA);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius - 5), (-math.pi / 2) + (2 * math.pi * 0.79), 2 * math.pi * 0.17, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}