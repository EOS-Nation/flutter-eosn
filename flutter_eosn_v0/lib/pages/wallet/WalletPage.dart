import 'package:flutter/material.dart';
import 'package:fluttereosnv0/models/walletAccount.dart';
import 'package:fluttereosnv0/pages/wallet/WalletAccountCard.dart';
import 'package:fluttereosnv0/pages/wallet/WalletAccountDialog.dart';
import 'package:fluttereosnv0/pages/wallet/WalletAccountList.dart';
import 'package:fluttereosnv0/services/walletService.dart';

class WalletPage extends StatefulWidget {
  final WalletService walletService = WalletService();
  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  List<WalletAccount> walletAccounts;

  @override
  void initState() {
    super.initState();
    walletAccounts = widget.walletService.walletAccounts;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: WalletAccountdialog(isNew: true),
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
              WalletAccountCard(
                walletAccount: walletAccounts[1],
              ),
              SizedBox(
                height: 5,
              ),
              Text('Others'),
              SizedBox(
                height: 5,
              ),
              Expanded(
                  child: WalletAccountList(walletAccounts: walletAccounts)),
            ],
          ),
        ));
  }
}
