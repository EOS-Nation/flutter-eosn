class WalletAccount {
  final String firebaseUid;
  final String accountName;
  final String publicKey;
  final String privateKey;

  WalletAccount(
      {this.accountName, this.publicKey, this.privateKey, this.firebaseUid});
}
