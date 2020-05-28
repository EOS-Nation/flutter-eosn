import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/loading.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';
import 'package:fluttereosnv0/pages/ImportEOSAccount/ImportWithPrivateKeyForm.dart';
import 'package:fluttereosnv0/pages/ImportEOSAccount/SelectAccountToImport.dart';

class ImportEOSAccountPage extends StatefulWidget {
  @override
  _ImportEOSAccountPageState createState() => _ImportEOSAccountPageState();
}

class _ImportEOSAccountPageState extends State<ImportEOSAccountPage> {
  bool isLoading;
  List<WalletAccount> accounts;
  String eosNetworkName;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    accounts = [];
    eosNetworkName = '';
  }

  void displayAccountSelect(
      String eosNetworkName, List<WalletAccount> accounts) {
    setState(() {
      isLoading = true;
    });
    setState(() {
      isLoading = false;
      this.accounts = accounts;
      this.eosNetworkName = eosNetworkName;
    });
  }

  void importAccounts(List<WalletAccount> accounts) {
    for (var account in accounts) {
      print(account.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColorDark,
              elevation: 0.0,
              leading: accounts.isEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/eos_nation_logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )
                  : IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => setState(() {
                            return this.accounts = [];
                          })),
              title: Text('Import Accounts'),
              actions: <Widget>[],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: accounts.isEmpty
                  ? ImportWithPrivateKeyForm(displayAccountSelect)
                  : SelectAccountToImport(
                      eosNetworkName, accounts, importAccounts),
            ),
          );
  }
}
