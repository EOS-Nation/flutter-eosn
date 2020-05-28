import 'package:fluttereosnv0/models/EOSNetwork.dart';
import 'package:uuid/uuid.dart';

class WalletAccount {
  String id;
  EOSNetwork network;
  String accountName;
  String publicKey;
  String privateKey;

  WalletAccount(this.accountName, this.publicKey, this.network,
      {String id, this.privateKey}) {
    this.id = id ?? Uuid().v4();
  }

  @override
  String toString() {
    return '{"id":"${this.id}","publicKey":"${this.publicKey}","privateKey":"${this.privateKey}","accountName":"${this.accountName}","networkName":"${this.network?.name}"}';
  }
}
