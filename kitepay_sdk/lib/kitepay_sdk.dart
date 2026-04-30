import 'dart:convert';

import 'package:http/http.dart' as http;

class Kitepay {
  final String apiKey;
  final String baseUrl = "https://api.kitepaygateway.com/v1";

  // Constructor using modern Dart named parameters
  Kitepay({required this.apiKey});

  // 1. CREATE A PAYMENT
  Future<Map<String, dynamic>?> createPayment({
    required int amount,
    required String currency,
    String? email,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/payments'),
        headers: _headers(),
        body: jsonEncode({
          'amount': amount,
          'currency': currency,
          'customer': {
            'email': email,
            'metadata': metadata,
          },
          'threeDSecure': {'required': true}
        }),
      );
      return _handleResponse(response);
    } catch (e) {
      print("Connection Error: $e");
      return null;
    }
  }

  // 2. LIST RECENT PAYMENTS
  Future<List<dynamic>?> listPayments(
      {int limit = 25, String status = 'completed'}) async {
    try {
      final url = Uri.parse('$baseUrl/payments?limit=$limit&status=$status');
      final response = await http.get(url, headers: _headers());
      final data = _handleResponse(response);
      return data != null ? data['data'] as List : null;
    } catch (e) {
      print("Fetch Error: $e");
      return null;
    }
  }

  // 3. CREATE INSTANT PAYOUT
  Future<Map<String, dynamic>?> createPayout({
    required int amount,
    required String currency,
    required String cardNumber,
    required String recipientName,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/payouts'),
        headers: _headers(),
        body: jsonEncode({
          'amount': amount,
          'currency': currency,
          'method': 'visa_direct',
          'recipient': {'cardNumber': cardNumber, 'name': recipientName}
        }),
      );
      return _handleResponse(response);
    } catch (e) {
      print("Payout Error: $e");
      return null;
    }
  }

  // PRIVATE HELPERS
  Map<String, String> _headers() {
    return {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
      'X-Idempotency-Key': DateTime.now().millisecondsSinceEpoch.toString(),
    };
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      print("API Error: ${response.statusCode} - ${response.body}");
      return null;
    }
  }
}
