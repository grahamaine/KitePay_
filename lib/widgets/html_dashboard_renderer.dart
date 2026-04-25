import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlDashboardRenderer extends StatelessWidget {
  // Use curly braces for named parameters in the constructor
  const HtmlDashboardRenderer({super.key});

  @override
  Widget build(BuildContext context) {
    // We define the HTML as a string inside the build method
    const String htmlData = """
      <div style="background-color: #161B22; padding: 20px; border-radius: 12px; border: 1px solid #30363D;">
        <h2 style="color: #58A6FF; font-family: sans-serif;">KitePay Analytics</h2>
        <p style="color: #8B949E; line-height: 1.5;">
          This section is rendered using <strong>HTML/CSS</strong> inside Flutter. 
          Perfect for complex text formatting or legacy web content.
        </p>
        <ul style="color: #c9d1d9;">
          <li>Real-time Latency: 12ms</li>
          <li>Network: Solana Mainnet</li>
        </ul>
      </div>
    """;

    return SingleChildScrollView(
      child: Html(
        data: htmlData,
        // Optional: Style specific tags using the Style class
        style: {
          "body": Style(
            margin: Margins.zero,
            padding: HtmlPaddings.zero,
          ),
        },
      ),
    );
  }
}