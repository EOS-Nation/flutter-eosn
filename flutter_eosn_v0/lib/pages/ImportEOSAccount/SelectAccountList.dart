import 'package:flutter/material.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';
import 'package:fluttereosnv0/pages/ImportEOSAccount/SelectAccountCard.dart';

class SelectAccountList extends StatelessWidget {
  final Function onImport;
  final List<WalletAccount> walletAccounts;

  SelectAccountList({this.onImport, this.walletAccounts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: walletAccounts.length,
      itemBuilder: (context, index) {
        return SelectAccountCard(
          walletAccount: walletAccounts[index],
          onImport: onImport,
        );
      },
    );
  }
}
