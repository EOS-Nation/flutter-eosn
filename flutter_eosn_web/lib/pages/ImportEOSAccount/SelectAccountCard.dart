import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/dialog/importDialog.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';

class SelectAccountCard extends StatelessWidget {
  final Function onImport;
  final WalletAccount walletAccount;

  SelectAccountCard({this.onImport, this.walletAccount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                walletAccount.accountName,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
          onTap: () {
            if (onImport != null) {
              return showDialog(
                  context: context,
                  child: ImportDialog(
                    onImport: () {
                      onImport([walletAccount]);
                    },
                    text: 'Do you want to import this account',
                  ));
            }
            return null;
          }),
    );
  }
}
