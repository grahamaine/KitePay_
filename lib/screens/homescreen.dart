import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Theme Colors from your HTML
  static const Color bgColor = Color(0xFF0A0A0C);
  static const Color surfaceColor = Color(0xFF111115);
  static const Color accentColor = Color(0xFF6C5CE7);
  static const Color btcColor = Color(0xF7931A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopbar(),
              const SizedBox(height: 32),
              _buildHeroSection(),
              const SizedBox(height: 32),
              _buildBTCCard(),
              const SizedBox(height: 24),
              _buildQuickActions(),
              const SizedBox(height: 32),
              _buildAssetSection(),
              const SizedBox(height: 100), // Space for Bottom Nav
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildNavbar(),
    );
  }

  // ── TOPBAR WIDGET ──
  Widget _buildTopbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [accentColor, Color(0xFF00D2D3)]),
              ),
              alignment: Alignment.center,
              child: const Text("AK", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("GOOD MORNING", style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 1.2)),
                Text("Alex Kite", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: surfaceColor,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white10),
          ),
          child: const Icon(Icons.notifications_none, color: Colors.white, size: 20),
        ),
      ],
    );
  }

  // ── HERO SECTION ──
  Widget _buildHeroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("TOTAL PORTFOLIO VALUE", style: TextStyle(color: Colors.grey, fontSize: 11, letterSpacing: 1.5)),
        const SizedBox(height: 8),
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(text: "\$", style: TextStyle(fontSize: 24, color: Color(0xFFA29BFE), fontWeight: FontWeight.w300)),
              TextSpan(text: "12,450", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white)),
              TextSpan(text: ".82", style: TextStyle(fontSize: 24, color: Colors.grey)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
              child: const Text("▲ 4.2%", style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 8),
            const Text("+\$501.34 today", style: TextStyle(color: Colors.grey, fontSize: 13)),
          ],
        )
      ],
    );
  }

  // ── BTC CARD (Modern Gradient) ──
  Widget _buildBTCCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
        ),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("BITCOIN WALLET", style: TextStyle(color: Colors.white54, fontSize: 10, letterSpacing: 1.2)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.cyan.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: const Text("Mainnet Live", style: TextStyle(color: Colors.cyanAccent, fontSize: 10)),
              )
            ],
          ),
          const SizedBox(height: 20),
          const Text("0.14823 BTC", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
          const Text("≈ \$9,841.20 USD", style: TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 24),
          const Text("bc1qxy2kgdygjrsqtzq2n0yrf2493p8...8842", style: TextStyle(color: Colors.white24, fontSize: 10, fontFamily: 'monospace')),
        ],
      ),
    );
  }

  // ── QUICK ACTIONS ──
  Widget _buildQuickActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _actionItem("Send", "📤", const Color(0xFF6C5CE7).withOpacity(0.15)),
        _actionItem("Receive", "📥", const Color(0xFF00B894).withOpacity(0.15)),
        _actionItem("Swap", "🔄", const Color(0xFFFDCB6E).withOpacity(0.15)),
        _actionItem("Vault", "🔒", const Color(0xFFA29BFE).withOpacity(0.15)),
      ],
    );
  }

  Widget _actionItem(String label, String icon, Color color) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.05))),
          alignment: Alignment.center,
          child: Text(icon, style: const TextStyle(fontSize: 24)),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  // ── ASSETS LIST ──
  Widget _buildAssetSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Your Assets", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            Text("See all →", style: TextStyle(color: accentColor.withOpacity(0.8), fontSize: 12)),
          ],
        ),
        const SizedBox(height: 16),
        _assetTile("Bitcoin", "BTC", "\$9,841", "▲ 5.1%", "₿", const Color(0xFFF7931A)),
        _assetTile("Ethereum", "ETH", "\$2,108", "▲ 2.3%", "Ξ", const Color(0xFF627EEA)),
      ],
    );
  }

  Widget _assetTile(String name, String sym, String val, String change, String icon, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: surfaceColor, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.05))),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: accent.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            alignment: Alignment.center,
            child: Text(icon, style: TextStyle(color: accent, fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              Text(sym, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ]),
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(val, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
            Text(change, style: const TextStyle(color: Colors.green, fontSize: 12)),
          ]),
        ],
      ),
    );
  }

  // ── NAVBAR ──
  Widget _buildNavbar() {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, top: 12),
      decoration: const BoxDecoration(
        color: surfaceColor,
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navIcon(Icons.home_filled, "Home", true),
          _navIcon(Icons.bar_chart_rounded, "Markets", false),
          _navIcon(Icons.qr_code_scanner, "Pay", false),
          _navIcon(Icons.lock_outline, "Vaults", false),
        ],
      ),
    );
  }

  Widget _navIcon(IconData icon, String label, bool active) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: active ? const Color(0xFFA29BFE) : Colors.grey, size: 26),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: active ? const Color(0xFFA29BFE) : Colors.grey, fontSize: 10)),
      ],
    );
  }
}