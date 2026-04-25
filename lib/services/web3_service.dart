import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Web3Service {
  late Web3Client _client;

    Web3Service() {
        // Initialize the client using your Alchemy URL from .env
        _client = Web3Client(dotenv.get('ETH_RPC_URL'), Client());
    }

    Future<String> getBalance() async {
    try {
      final address = EthereumAddress.fromHex(dotenv.get('KITE_ETH_ADDRESS'));
      EtherAmount balance = await _client.getBalance(address);

        // Convert Wei to ETH and format to 4 decimal places
        return balance.getValueInUnit(EtherUnit.ether).toStringAsFixed(4);
    } catch (e) {
        return "0.0000";
    }
}
}