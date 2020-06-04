import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/dialog/deleteDialog.dart';
import 'package:fluttereosnv0/commons/dialog/selectDialog.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';
import 'package:fluttereosnv0/pages/wallet/WalletAccountDialog.dart';

class WalletAccountCard extends StatelessWidget {
  final Function onDelete;
  final Function onSelect;
  final WalletAccount walletAccount;

  WalletAccountCard({this.onDelete, this.onSelect, this.walletAccount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => showDialog(
                  context: context,
                  child: DeleteDialog(
                    () => onDelete(walletAccount.id),
                    deleteText: 'Do you want to delete this account',
                  ))),
          title: Text(
            walletAccount.accountName,
            style: TextStyle(fontSize: 20),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Text(
                walletAccount.publicKey,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
          onTap: () {
            if (onSelect != null) {
              return showDialog(
                  context: context,
                  child: SelectDialog(
                    onSelect: () => onSelect(walletAccount),
                    selectText: 'Do you want to use this account',
                  ));
            }
            return null;
          }),
    );
  }
}
