import 'package:flutter/material.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';
import 'package:fluttereosnv0/pages/ImportEOSAccount/SelectAccountList.dart';

class SelectAccountToImport extends StatelessWidget {
  final String eosNetworkName;
  final List<WalletAccount> accounts;
  final Function importAccounts;

  SelectAccountToImport(
    this.eosNetworkName,
    this.accounts,
    this.importAccounts,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                eosNetworkName,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              RaisedButton(
                child: Text('Import All'),
                onPressed: () {
                  importAccounts(accounts);
                },
                color: Theme.of(context).buttonColor,
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: SelectAccountList(
            walletAccounts: accounts,
            onSelect: importAccounts,
          )),
        ],
      ),
    );
  }
}
