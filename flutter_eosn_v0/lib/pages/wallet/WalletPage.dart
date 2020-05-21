import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/loading.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';
import 'package:fluttereosnv0/pages/wallet/WalletAccountCard.dart';
import 'package:fluttereosnv0/pages/wallet/WalletAccountDialog.dart';
import 'package:fluttereosnv0/pages/wallet/WalletAccountList.dart';
import 'package:fluttereosnv0/services/walletManager.dart';

class WalletPage extends StatefulWidget {
  final WalletManager walletManager = WalletManager();
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  List<WalletAccount> walletAccounts;
  WalletAccount currentAccount;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    this.fetchAccount();
  }

  void fetchAccount() async {
    walletAccounts = await widget.walletManager.walletAccounts;
    currentAccount = widget.walletManager.currentAccount;
    setState(() {
      isLoading = false;
    });
  }

  void addAccount(String accountName, String publicKey, String privateKey) {
    setState(() {
      isLoading = true;
    });
    widget.walletManager.addAccount(accountName, publicKey, privateKey);
    setState(() {
      isLoading = false;
    });
  }

  void editAccount(
      String id, String accountName, String publicKey, String privateKey) {
    setState(() {
      isLoading = true;
    });
    widget.walletManager.editAccount(id,
        accountName: accountName, publicKey: publicKey, privateKey: privateKey);
    setState(() {
      isLoading = false;
    });
  }

  void deleteAccount(String id) {
    setState(() {
      isLoading = true;
    });
    widget.walletManager.deleteAccount(id);
    setState(() {
      isLoading = false;
    });
  }

  void selectAccount(WalletAccount currentAccount) {
    setState(() {
      isLoading = true;
    });
    widget.walletManager.currentAccount = currentAccount;
    setState(() {
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
              onPressed: () => showDialog(
                context: context,
                child: WalletAccountdialog(isNew: true, onAdd: this.addAccount),
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
              backgroundColor: Theme.of(context).buttonColor,
            ),
            body: Container(
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
                          onEdit: this.editAccount,
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
                          onEdit: this.editAccount,
                          onSelect: this.selectAccount)),
                ],
              ),
            ));
  }
}
