import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_html/flutter_html.dart';

// --- STATE MANAGEMENT ---

// A simple model for our Payment State
class PaymentState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  PaymentState({this.isLoading = false, this.errorMessage, this.isSuccess = false});

  PaymentState copyWith({bool? isLoading, String? errorMessage, bool? isSuccess}) {
    return PaymentState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

// The Logic Controller (Notifier)
class PaymentNotifier extends Notifier<PaymentState> {
  @override
  PaymentState build() => PaymentState();

  Future<void> processPayment(double amount) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    // Simulate an SDK call to KitePay
    await Future.delayed(const Duration(seconds: 2));

    if (amount <= 0) {
      state = state.copyWith(isLoading: false, errorMessage: "Invalid Amount");
    } else {
      state = state.copyWith(isLoading: false, isSuccess: true);
    }
  }

  void reset() => state = PaymentState();
}

// The Provider that the UI will listen to
final paymentProvider = NotifierProvider<PaymentNotifier, PaymentState>(() {
  return PaymentNotifier();
});

// --- MAIN APP ENTRY ---

void main() {
  runApp(
    const ProviderScope(child: KitePayApp()),
  );
}

class KitePayApp extends StatelessWidget {
  const KitePayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KitePay 2026',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const CheckoutScreen(),
    );
  }
}

// --- UI COMPONENTS ---

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  // Example HTML content for the invoice
  final String htmlInvoice = """
    <div style="text-align: center;">
      <h2 style="color: #2196F3;">KitePay Invoice</h2>
      <p>Order #772910</p>
      <hr>
      <p style="font-size: 18px;">Total Due: <b>\$150.00</b></p>
    </div>
  """;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentState = ref.watch(paymentProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("KitePay Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // HTML Rendering of the Invoice
            Card(
              elevation: 4,
              child: Html(data: htmlInvoice),
            ),
            const Spacer(),
            
            // Error Handling
            if (paymentState.errorMessage != null)
              Text(paymentState.errorMessage!, style: const TextStyle(color: Colors.red)),

            // Success State
            if (paymentState.isSuccess)
              const Column(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 60),
                  Text("Payment Successful!", style: TextStyle(fontSize: 20)),
                ],
              ),

            const SizedBox(height: 20),

            // Action Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: paymentState.isLoading || paymentState.isSuccess
                    ? null
                    : () => ref.read(paymentProvider.notifier).processPayment(150.0),
                child: paymentState.isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Pay with KitePay"),
              ),
            ),
            
            if (paymentState.isSuccess)
              TextButton(
                onPressed: () => ref.read(paymentProvider.notifier).reset(),
                child: const Text("Reset Demo"),
              )
          ],
        ),
      ),
    );
  }
}
