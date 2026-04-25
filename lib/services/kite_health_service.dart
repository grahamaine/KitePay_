import 'dart:async';

import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

enum KiteStatus { healthy, degraded, stuck, offline }

class KiteHealthService {
  final String _rpcUrl = "https://rpc.gokite.ai";
  late Web3Client _client;

  final _healthController = StreamController<KiteHealthMetrics>.broadcast();
  Stream<KiteHealthMetrics> get healthStream => _healthController.stream;

  KiteHealthService() {
    _client = Web3Client(_rpcUrl, Client());
    // Start the heartbeat every 3 seconds
    Timer.periodic(const Duration(seconds: 3), (_) => checkHealth());
  }

  Future<void> checkHealth() async {
    final stopwatch = Stopwatch()..start();

    try {
      // 1. Get the latest block details (for timestamp/drift)
      final block = await _client.getBlockInformation(blockNumber: 'latest');

      // 2. Get the block height directly (Fixes the 'blockNumber' getter error)
      final int currentBlockHeight = await _client.getBlockNumber();

      final int latency = stopwatch.elapsedMilliseconds;
      final int now = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      // Convert block timestamp to seconds
      final int blockTimestamp = block.timestamp.millisecondsSinceEpoch ~/ 1000;
      final int drift = now - blockTimestamp;

      // Determine network status based on 2026 performance standards
      KiteStatus status = KiteStatus.healthy;
      if (latency > 800 || drift > 15) status = KiteStatus.degraded;
      if (latency > 3000 || drift > 45) status = KiteStatus.stuck;

      _healthController.add(
        KiteHealthMetrics(
          latency: latency,
          drift: drift,
          status: status,
          blockNumber: currentBlockHeight.toInt(), // Convert BigInt to int
        ),
      );
    } catch (e) {
      // If the RPC fails entirely
      _healthController.add(
        KiteHealthMetrics(
          latency: 0,
          drift: 0,
          status: KiteStatus.offline,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void dispose() {
    _healthController.close();
  }
}

class KiteHealthMetrics {
  final int latency;
  final int drift;
  final KiteStatus status;
  final int blockNumber;
  final String? errorMessage;

  KiteHealthMetrics({
    required this.latency,
    required this.drift,
    required this.status,
    this.blockNumber = 0,
    this.errorMessage,
  });
}
