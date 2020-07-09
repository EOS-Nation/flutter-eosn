import 'package:flutter/material.dart';
import 'package:myapp/commons/loading.dart';
import 'package:myapp/models/pings.dart';
import 'package:myapp/pages/pingPong/ping.dart';
import 'package:myapp/pages/pingPong/pingsExpansionTiles.dart';
import 'package:myapp/pages/wallet/WalletPage.dart';
import 'package:myapp/services/pingPongContract.dart';
import 'package:myapp/services/walletManager.dart';

class PingPong extends StatefulWidget {
  @override
  _PingPongState createState() => _PingPongState();
}

class _PingPongState extends State<PingPong> {
  bool isLoading;
  WalletManager walletManager;
  PingPongContract _pingPongContract;
  bool noCurrentAccount;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    noCurrentAccount = false;
    this.fetchAccount();
  }

  Future<void> fetchAccount() async {
    walletManager = await WalletManager.create();
    setState(() {
      noCurrentAccount =
          walletManager == null || walletManager.currentAccount == null;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (noCurrentAccount) {
      return WalletPage();
    }
    _pingPongContract = PingPongContract(
        nodeURL: walletManager.currentAccount.network.nodeURL,
        nodeVersion: 'v1');

    return isLoading
        ? Loading()
        : FutureBuilder(
            future: _pingPongContract.getTableRows(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Pings>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Loading();
                default:
                  return Scaffold(
                      backgroundColor: Theme.of(context).primaryColor,
                      appBar: AppBar(
                        backgroundColor: Theme.of(context).primaryColorDark,
                        elevation: 0.0,
                        title: Text('EOS Dart'),
                      ),
                      body: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                color: Theme.of(context).buttonColor,
                                child: Text('Ping'),
                                onPressed: () async {
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Ping(
                                              pushPing:
                                                  _pingPongContract.pushPing,
                                            )),
                                  );
                                  setState(() {});
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              RaisedButton(
                                  color: Theme.of(context).buttonColor,
                                  child: Text('Clear'),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title:
                                            Text('Do you want to clear pings?'),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('Clear'),
                                            onPressed: () {
                                              _pingPongContract.pushClear();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          FlatButton(
                                            child: Text('Cancel'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          snapshot.hasError
                              ? Text('Error: ${snapshot.error}',
                                  style: TextStyle(fontSize: 20))
                              : PingsExpansionTiles(
                                  pings: snapshot.data,
                                  pushPong: (
                                      {String account, String trxId}) async {
                                    await _pingPongContract.pushPong(
                                        account: account, trxId: trxId);
                                    setState(() {});
                                  },
                                )
                        ],
                      ));
              }
            });
  }
}
