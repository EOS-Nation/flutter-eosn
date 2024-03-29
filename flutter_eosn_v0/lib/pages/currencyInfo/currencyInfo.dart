import 'package:flutter/material.dart';
import 'package:fluttereosnv0/commons/loading.dart';
import 'package:fluttereosnv0/models/cryptoCurrency.dart';
import 'package:fluttereosnv0/pages/currencyInfo/currencyInfoPage.dart';
import 'package:fluttereosnv0/pages/currencyInfo/currencyList.dart';
import 'package:fluttereosnv0/services/auth.dart';
import 'package:fluttereosnv0/services/cryptoCurrencyAPI.dart';

class CurrencyInfo extends StatefulWidget {
  final List<CryptoCurrencyAPI> currencies;
  CurrencyInfo({this.currencies});
  @override
  _CurrencyInfoState createState() => _CurrencyInfoState();
}

class _CurrencyInfoState extends State<CurrencyInfo> {
  bool isLoading;
  bool displayCurrencyInfoPage;
  int cryptoCurrencyIndex;
  List<CryptoCurrency> cryptoCurencies;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    displayCurrencyInfoPage = false;
    cryptoCurrencyIndex = 0;
    cryptoCurencies = [];
    this.fetchCurrenciesInfo();
  }

  void fetchCurrenciesInfo() async {
    for (var item in widget.currencies) {
      CryptoCurrency temp = await item.getCurrencyInfo();
      if (temp != null) {
        cryptoCurencies.add(temp);
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  void toggleDisplay(int cryptoCurrencyIndex) {
    setState(() {
      this.cryptoCurrencyIndex = cryptoCurrencyIndex;
      this.displayCurrencyInfoPage = !displayCurrencyInfoPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return isLoading
        ? Loading()
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColorDark,
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0.0,
              leading: displayCurrencyInfoPage
                  ? IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        if (displayCurrencyInfoPage) {
                          toggleDisplay(null);
                        }
                      },
                    )
                  : null,
              title: Text('CryptoCurrency Value'),
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
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
            body: displayCurrencyInfoPage
                ? Container(
                    child: CryptoInfoCard(
                        cryptoCurrencyInfo:
                            cryptoCurencies[cryptoCurrencyIndex]))
                : CurrencyList(
                    cryptocurencies: cryptoCurencies,
                    toggleDisplay: toggleDisplay),
          );
  }
}
