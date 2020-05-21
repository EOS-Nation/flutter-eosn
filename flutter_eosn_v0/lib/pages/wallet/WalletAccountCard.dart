import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/deleteDialog.dart';
import 'package:fluttereosnv0/commons/selectDialog.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';
import 'package:fluttereosnv0/pages/wallet/WalletAccountDialog.dart';

class WalletAccountCard extends StatelessWidget {
  final WalletAccount walletAccount;

  WalletAccountCard({this.walletAccount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          trailing: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'delete') {
                showDialog(
                    context: context,
                    child: DeleteDialog(
                      deleteText: 'Do you want to delete this account',
                    ));
              } else if (value == 'edit') {
                showDialog(
                  context: context,
                  child: WalletAccountdialog(
                      walletAccount: walletAccount, isNew: true),
                );
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'delete',
                child: Text("Delete"),
              ),
              PopupMenuItem(
                value: 'edit',
                child: Text("Edit"),
              ),
            ],
          ),
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
          onTap: () => showDialog(
              context: context,
              child: SelectDialog(
                selectText: 'Do you want to use this account',
              ))),
    );
  }
}
