import 'package:eosdart/eosdart.dart';
import 'package:eosdart_ecc/eosdart_ecc.dart';
import 'package:fluttereosnv0/models/EOSNetwork.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';

class EOSService {
  static EOSClient _client;

  EOSService(EOSNetwork network) {
    _client = EOSClient(
      network.nodeURL,
      network.nodeVersion,
    );
  }

  Future<List<WalletAccount>> getAccountsFromPrivateKey(
      String privateKey) async {
    String publicKey = this.getPublicKeyFromPrivateKey(privateKey);

    AccountNames account = await _client.getKeyAccountsV2(publicKey);
    return account.accountNames
        .map((accountName) => WalletAccount(
              accountName: accountName,
              publicKey: publicKey,
            ))
        .toList();
  }

  String getPublicKeyFromPrivateKey(String privateKey) {
    EOSPrivateKey eosPrivateKey = EOSPrivateKey.fromString(privateKey);
    return eosPrivateKey.toEOSPublicKey().toString();
  }
}
