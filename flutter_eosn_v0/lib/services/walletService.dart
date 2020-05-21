import 'package:fluttereosnv0/models/walletAccount.dart';

class WalletService {
  List<WalletAccount> _walletAccounts = [
    WalletAccount(
        accountName: 'Paco',
        publicKey: 'EOS4vNRQnPLXVLtdAbCrffKDd2UZ6vX6unEQSGxhjvjCrPRtFVDgC',
        privateKey: '5JaYgZrSCk5aHPR1MPxTnmEdS3nwzV9u9yJ1eEAqabZS7ATrEVp'),
    WalletAccount(
        accountName: 'Paco2',
        publicKey: 'EOS4vNRQnPLXVLtdAbCrffKDd2UZ6vX6unEQSGxhjvjCrPRtsFVDgC',
        privateKey: '5JaYgZrSCk5aHPR1MPxTnmEdS3nwzV9u9yJ1eEAqabZS7ATrEVsp')
  ];

  List<WalletAccount> get walletAccounts {
    return _walletAccounts;
  }

  void addAccount(String accountName, String publicKey, String privateKey) {
    _walletAccounts.add(WalletAccount(
      accountName: accountName,
      publicKey: publicKey,
      privateKey: privateKey,
    ));
  }

  void editAccount(String id,
      {String accountName, String publicKey, String privateKey}) {
    _walletAccounts.add(WalletAccount(
      accountName: accountName,
      publicKey: publicKey,
      privateKey: privateKey,
    ));
  }

  void deleteAccount(String id,
      {String accountName, String publicKey, String privateKey}) {}
}
