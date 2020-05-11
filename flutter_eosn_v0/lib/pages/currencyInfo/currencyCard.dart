import 'package:fluttereosnv0/models/cryptoCurrency.dart';
import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  final int cryptoCurrencyIndex;
  final CryptoCurrency cryptoCurrency;
  final Function toggleDisplay;
  CurrencyCard(
      {this.cryptoCurrency, this.toggleDisplay, this.cryptoCurrencyIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: Image.network(cryptoCurrency.imgSrc),
          title: Text(
            cryptoCurrency.name,
            style: TextStyle(fontSize: 20),
          ),
          onTap: () async {
            toggleDisplay(cryptoCurrencyIndex);
          },
        ),
      ),
    );
  }
}
