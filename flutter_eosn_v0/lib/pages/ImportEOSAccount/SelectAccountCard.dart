import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/dialog/selectDialog.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';

class SelectAccountCard extends StatelessWidget {
  final Function onSelect;
  final WalletAccount walletAccount;

  SelectAccountCard({this.onSelect, this.walletAccount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Text(
            walletAccount.accountName,
            style: TextStyle(fontSize: 20),
          ),
          onTap: () {
            if (onSelect != null) {
              return showDialog(
                  context: context,
                  child: SelectDialog(
                    onSelect: () {
                      onSelect([walletAccount]);
                    },
                    selectText: 'Do you want to import this account',
                  ));
            }
            return null;
          }),
    );
  }
}
