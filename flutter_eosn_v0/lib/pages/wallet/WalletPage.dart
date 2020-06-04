import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/eosToast.dart';
import 'package:fluttereosnv0/commons/loading.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';
import 'package:fluttereosnv0/pages/ImportEOSAccount/ImportEOSAccountPage.dart';
import 'package:fluttereosnv0/pages/wallet/WalletAccountCard.dart';
import 'package:fluttereosnv0/pages/wallet/WalletAccountList.dart';
import 'package:fluttereosnv0/services/walletManager.dart';

class WalletPage extends StatefulWidget {
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  WalletManager walletManager;
  List<WalletAccount> walletAccounts;
  WalletAccount currentAccount;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    this.fetchAccount();
  }

  Future<void> fetchAccount() async {
    walletManager = await WalletManager.create();
    walletAccounts = await walletManager.walletAccounts;
    currentAccount = walletManager.currentAccount;
    setState(() {
      isLoading = false;
    });
  }

  void deleteAccount(String id) {
    walletManager.deleteAccount(id);
    if (currentAccount?.id == id) {
      currentAccount = null;
    }
    setState(() {
      walletAccounts.removeWhere((element) => element.id == id);
      isLoading = false;
    });
  }

  void selectAccount(WalletAccount currentAccount) {
    setState(() => isLoading = true);
    walletManager.currentAccount = currentAccount;
    setState(() {
      this.currentAccount = currentAccount;
      isLoading = false;
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
              leading: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/eos_nation_logo.png'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              title: Text('Wallet'),
              actions: <Widget>[],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImportEOSAccountPage()),
                );
                this.fetchAccount();
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).buttonColor,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Text('Current Account'),
                        SizedBox(
                          height: 5,
                        ),
                        this.currentAccount != null
                            ? WalletAccountCard(
                                onDelete: this.deleteAccount,
                                walletAccount: currentAccount,
                              )
                            : SizedBox(
                                height: 0,
                              ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Others'),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                            child: WalletAccountList(
                                walletAccounts: walletAccounts,
                                onDelete: this.deleteAccount,
                                onSelect: this.selectAccount)),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  color: Theme.of(context).buttonColor,
                  child: Text('Clear Storage'),
                  onPressed: () {
                    walletManager.clearSecureStorage();
                    EOSToast().infoCenterShortToast('Secure Storage Cleared');
                    setState(() {
                      walletAccounts = [];
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ));
  }
}
