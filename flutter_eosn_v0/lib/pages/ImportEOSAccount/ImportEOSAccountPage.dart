import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/eosToast.dart';
import 'package:fluttereosnv0/commons/loading.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';
import 'package:fluttereosnv0/pages/ImportEOSAccount/AccountsFromPrivateKeyForm.dart';
import 'package:fluttereosnv0/pages/ImportEOSAccount/SelectAccountToImport.dart';
import 'package:fluttereosnv0/services/walletManager.dart';

class ImportEOSAccountPage extends StatefulWidget {
  @override
  _ImportEOSAccountPageState createState() => _ImportEOSAccountPageState();
}

class _ImportEOSAccountPageState extends State<ImportEOSAccountPage> {
  WalletManager walletManager;
  bool isLoading;
  List<WalletAccount> accounts;
  String eosNetworkName;

  @override
  void initState() {
    super.initState();
    isLoading = false;
    accounts = [];
    eosNetworkName = '';
    this.fetchWalletManager();
  }

  void fetchWalletManager() async {
    walletManager = await WalletManager.create();
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
                            Navigator.pop(context);
                          })),
              title: Text('Import Accounts'),
              actions: <Widget>[],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: accounts.isEmpty
                  ? AccountsFromPrivateKeyForm(displayAccountSelect)
                  : SelectAccountToImport(
                      eosNetworkName, accounts, importAccounts),
            ),
          );
  }
}
