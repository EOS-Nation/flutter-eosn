class WalletAccount {
  String id;
  String accountName;
  String publicKey;
  String privateKey;

  WalletAccount({this.accountName, this.publicKey, this.privateKey, this.id});

  @override
  String toString() {
    return '{"id":"${this.id}","publicKey":"${this.publicKey}","privateKey":"${this.privateKey}","accountName":"${this.accountName}"}';
  }
}
