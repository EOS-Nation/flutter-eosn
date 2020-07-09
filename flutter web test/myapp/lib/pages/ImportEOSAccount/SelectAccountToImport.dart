import 'package:flutter/material.dart';
import 'package:myapp/models/walletAccount.dart';
import 'package:myapp/pages/ImportEOSAccount/SelectAccountList.dart';

class SelectAccountToImport extends StatelessWidget {
  final Map<String, List<WalletAccount>> accounts;
  final Function importAccounts;

  SelectAccountToImport(
    this.accounts,
    this.importAccounts,
  );

  @override
  Widget build(BuildContext context) {
    var keys = accounts.keys.toList();

    List<Widget> cards = [];
    for (var key in keys) {
      var list = accounts[key];
      if (list != null && list.isNotEmpty) {
        cards.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                list.first?.network?.name,
                style: TextStyle(fontSize: 20),
              )),
        ));
        cards.add(
          Expanded(
            child: SelectAccountList(
              walletAccounts: accounts[key],
              onImport: importAccounts,
            ),
          ),
        );
      }
    }

    cards.add(
      Spacer(),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Column(
              children: cards,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RaisedButton(
              child: Text('Import All Accounts'),
              onPressed: () {
                for (var key in keys) {
                  var list = accounts[key];
                  if (list != null && list.isNotEmpty) {
                    importAccounts(accounts[key]);
                  }
                }
              },
              color: Theme.of(context).buttonColor,
            ),
          )
        ],
      ),
    );
  }
}
