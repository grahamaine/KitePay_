import 'package:http/http.dart' as http;
import 'dart:convert';

class KiteAgentService {
  final String baseUrl = "https://api.agentpass.space"; // Standard Kite/AgentPass API

  // 1. Create the Agent Identity
  Future<Map<String, dynamic>> createAgent(String name) async {
    // In a real app, you'd generate a key pair locally first.
    // For now, we register the agent with the Kite Passport protocol.
    final response = await http.post(
      Uri.parse('$baseUrl/passports'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'description': 'KitePay Mobile Agent',
        'public_key': 'YOUR_GENERATED_PUBLIC_KEY_B64', 
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body); // Returns your Passport ID (e.g., ap_x123...)
    } else {
      throw Exception('Failed to register Kite Agent');
    }
  }

  // 2. Request a Spending Session
  // This triggers the "Approve" notification on the user's phone
  Future<void> requestSession(double budgetLimit) async {
    // Logic to request a signed spending session from the Kite Chain
  }
}