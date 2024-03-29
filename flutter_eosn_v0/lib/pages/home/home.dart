import 'package:flutter/material.dart';
import 'package:fluttereosnv0/pages/ImportEOSAccount/ImportEOSAccountPage.dart';
import 'package:fluttereosnv0/pages/currencyInfo/currencyInfo.dart';
import 'package:fluttereosnv0/pages/wallet/WalletPage.dart';
import 'package:fluttereosnv0/pages/pingPong/pingPongPage.dart';
import 'package:fluttereosnv0/services/auth.dart';
import 'package:fluttereosnv0/services/cryptoCurrencyAPI.dart';

class Home extends StatelessWidget {
  final List<CryptoCurrencyAPI> cryptoCurencies = [
    CryptoCurrencyAPI(currencyName: 'eos'),
    CryptoCurrencyAPI(currencyName: 'Bitcoin'),
    CryptoCurrencyAPI(currencyName: 'Ethereum'),
    CryptoCurrencyAPI(currencyName: 'Ripple'),
    CryptoCurrencyAPI(currencyName: 'Tether'),
    CryptoCurrencyAPI(currencyName: 'Bitcoin-Cash'),
    CryptoCurrencyAPI(currencyName: 'litecoin')
  ];

  final AuthService _auth = AuthService();
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
        title: Text('Home'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: RaisedButton(
              color: Theme.of(context).buttonColor,
              child: Text(
                'Sign Off',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            RaisedButton(
              color: Theme.of(context).buttonColor,
              child: Text('Currency Info Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CurrencyInfo(currencies: cryptoCurencies)),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Theme.of(context).buttonColor,
              child: Text('Ping Pong Contract Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PingPong()),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Theme.of(context).buttonColor,
              child: Text('Wallet'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WalletPage(),
                    ));
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
