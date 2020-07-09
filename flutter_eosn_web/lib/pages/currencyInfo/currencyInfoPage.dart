import 'package:flutter/material.dart';
import 'package:fluttereosnv0/models/cryptoCurrency.dart';

class CryptoInfoCard extends StatelessWidget {
  final CryptoCurrency cryptoCurrencyInfo;
  CryptoInfoCard({this.cryptoCurrencyInfo});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.network(cryptoCurrencyInfo.imgSrc),
          SizedBox(
            width: 5,
          ),
          Text(
            cryptoCurrencyInfo.name,
            style: TextStyle(
              fontSize: 35,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Text("USD Prices : "),
              Text(cryptoCurrencyInfo.usdPrice),
              Text(" \$"),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: <Widget>[
              Text("USD MarketShare : "),
              Text(cryptoCurrencyInfo.usdMarketShare),
              Text(" \$"),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
