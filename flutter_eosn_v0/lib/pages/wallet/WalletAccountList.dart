import 'package:flutter/material.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';
import 'package:fluttereosnv0/pages/wallet/WalletAccountCard.dart';

class WalletAccountList extends StatelessWidget {
  final Function onDelete;
  final Function onSelect;
  final List<WalletAccount> walletAccounts;

  WalletAccountList({this.onDelete, this.onSelect, this.walletAccounts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: walletAccounts.length,
      itemBuilder: (context, index) {
        return WalletAccountCard(
          walletAccount: walletAccounts[index],
          onDelete: onDelete,
          onSelect: onSelect,
        );
      },
    );
  }
}
