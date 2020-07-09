import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:myapp/commons/eosToast.dart';
import 'package:myapp/commons/loading.dart';
import 'package:myapp/models/walletAccount.dart';
import 'package:myapp/pages/ImportEOSAccount/AccountsFromPrivateKeyForm.dart';
import 'package:myapp/pages/ImportEOSAccount/SelectAccountToImport.dart';
import 'package:myapp/services/walletManager.dart';

class ImportEOSAccountPage extends StatefulWidget {
  @override
  _ImportEOSAccountPageState createState() => _ImportEOSAccountPageState();
}

class _ImportEOSAccountPageState extends State<ImportEOSAccountPage> {
  WalletManager walletManager;
  bool isSelectAccountPage;
  bool isLoading;
  HashMap<String, List<WalletAccount>> accountsNetworks;
  String eosNetworkName;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    isSelectAccountPage = false;
    accountsNetworks = HashMap();
    this.fetchWalletManager();
  }

  void fetchWalletManager() async {
    walletManager = await WalletManager.create();
  }

  void addAccountsToMap(String eosNetworkName, List<WalletAccount> accounts) {
    accountsNetworks[eosNetworkName.toLowerCase()] = accounts;
  }

  Future<void> importAccounts(List<WalletAccount> accounts) async {
    if (accounts == null || accounts.isEmpty) {
      EOSToast().errorCenterShortToast('Error importing account');
      return;
    }

    for (var account in accounts) {
      if (walletManager.hasAccount(account)) {
        EOSToast().infoCenterShortToast('Account already imported');
      } else {
        walletManager.addAccount(
            account.accountName, account.publicKey, account.network.name,
            privateKey: account.privateKey);
        EOSToast().infoCenterShortToast('Import Successful');
      }
    }
    Navigator.pop(context);
  }

  void toggleSelectAccountPage() {
    setState(() {
      isSelectAccountPage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColorDark,
              elevation: 0.0,
              leading: isSelectAccountPage
                  ? IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () => setState(() {
                            Navigator.pop(context);
                          }))
                  : Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/eos_nation_logo.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
              title: Text('Import Accounts'),
              actions: <Widget>[],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                child: isSelectAccountPage
                    ? SelectAccountToImport(accountsNetworks, importAccounts)
                    : AccountsFromPrivateKeyForm(
                        addAccountsToMap, toggleSelectAccountPage)),
          );
  }
}
