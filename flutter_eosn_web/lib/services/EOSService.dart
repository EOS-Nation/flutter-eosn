import 'package:eosdart/eosdart.dart';
import 'package:eosdart_ecc/eosdart_ecc.dart';
import 'package:fluttereosnv0/models/EOSNetwork.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';

class EOSService {
  static final Map<String, EOSNetwork> eosNetworks = {
    'jungle2': EOSNetwork('Jungle2', 'https://jungle2.cryptolions.io', 'v2'),
    'jungle3':
        EOSNetwork('Jungle3', 'https://jungle3history.cryptolions.io', 'v2'),
    'mainnet': EOSNetwork('Mainet', 'https://mainnet.eosn.io', 'v2'),
  };
  // 'jungle3': EOSNetwork('Jungle3', 'https://jungle3.cryptolions.io', 'v2'),
  // 'mainnet': EOSNetwork('Mainet', 'api.eosn.io:9876', 'v2'),

  EOSClient _client;
  String _eosNetworkName;

  EOSService() {
    this.updateEOSClient(eosNetworks['jungle3']);
  }

  void updateEOSClient(EOSNetwork network) {
    _client = EOSClient(
      network.nodeURL,
      network.nodeVersion,
    );
    _eosNetworkName = network.name;
  }

  Future<List<WalletAccount>> getAccountsFromPrivateKey(
      String privateKey) async {
    String publicKey = this.getPublicKeyFromPrivateKey(privateKey);
    AccountNames account = await _client.getKeyAccountsV2(publicKey);
    return account.accountNames
        .map((accountName) => WalletAccount(accountName.trim(),
            publicKey.trim(), eosNetworks[_eosNetworkName.toLowerCase()],
            privateKey: privateKey))
        .toList();
  }

  String getPublicKeyFromPrivateKey(String privateKey) {
    EOSPrivateKey eosPrivateKey = EOSPrivateKey.fromString(privateKey);
    return eosPrivateKey.toEOSPublicKey().toString();
  }
}
