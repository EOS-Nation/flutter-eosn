import 'package:flutter/material.dart';
import 'package:myapp/models/cryptoCurrency.dart';
import 'package:myapp/pages/currencyInfo/currencyCard.dart';

class CurrencyList extends StatelessWidget {
  final List<CryptoCurrency> cryptocurencies;
  final Function toggleDisplay;
  CurrencyList({this.cryptocurencies, this.toggleDisplay});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: ListView.builder(
        itemCount: cryptocurencies.length,
        itemBuilder: (context, index) {
          return CurrencyCard(
              cryptoCurrencyIndex: index,
              cryptoCurrency: cryptocurencies[index],
              toggleDisplay: toggleDisplay);
        },
      ),
    );
  }
}
