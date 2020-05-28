import 'package:fluttereosnv0/models/EOSNetwork.dart';

class WalletAccount {
  String id;
  EOSNetwork network;
  String accountName;
  String publicKey;
  String privateKey;

  WalletAccount(
      {this.accountName,
      this.publicKey,
      this.privateKey,
      this.id,
      this.network});

  @override
  String toString() {
    return '{"id":"${this.id}","publicKey":"${this.publicKey}","privateKey":"${this.privateKey}","accountName":"${this.accountName}"}';
  }
}
