import 'package:flutter/material.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';
import 'package:fluttereosnv0/pages/wallet/WalletAccountList.dart';

class SelectAccountToImport extends StatelessWidget {
  final List<WalletAccount> accounts;
  SelectAccountToImport(this.accounts);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: WalletAccountList(walletAccounts: accounts));
  }
}
