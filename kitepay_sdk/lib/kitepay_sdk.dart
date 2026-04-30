import 'dart:convert';

import 'package:http/http.dart' as http;

enum KitepayEnvironment { sandbox, production }

class Kitepay {
  final String apiKey;
  final KitepayEnvironment environment;

  Kitepay({
    required this.apiKey,
    this.environment = KitepayEnvironment.sandbox,
  });

  String get _baseUrl => environment == KitepayEnvironment.production
      ? 'https://api.kitepaygateway.com/v1'
      : 'https://sandbox.kitepaygateway.com/v1';

  Map<String, String> get _headers => {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      };

  /// POST /v1/payments
  Future<Map<String, dynamic>?> createPayment({
    required int amount,
    required String currency,
    required String email,
  }) async {
    final url = Uri.parse('$_baseUrl/payments');
    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode({
        'amount': amount,
        'currency': currency,
        'customer': {'email': email},
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Payment Error: ${response.body}');
    }
  }

  /// POST /v1/payouts
  Future<Map<String, dynamic>?> createPayout({
    required int amount,
    required String currency,
    required String cardNumber,
    required String recipientName,
  }) async {
    final url = Uri.parse('$_baseUrl/payouts');
    final response = await http.post(
      url,
      headers: _headers,
      body: jsonEncode({
        'amount': amount,
        'currency': currency,
        'method': 'visa_direct',
        'recipient': {
          'cardNumber': cardNumber,
          'name': recipientName,
        },
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Payout Error: ${response.body}');
    }
  }
}
