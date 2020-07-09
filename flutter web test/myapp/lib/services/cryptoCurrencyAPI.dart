import 'dart:convert';

import 'package:http/http.dart';
import 'package:myapp/models/cryptoCurrency.dart';

class CryptoCurrencyAPI {
  String currencyName = '';
  CryptoCurrencyAPI({this.currencyName});
  CryptoCurrency _currencyInfo;

  Future<CryptoCurrency> getCurrencyInfo() async {
    if (_currencyInfo != null) {
      return _currencyInfo;
    } else {
      try {
        Response response = await get(
            'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=' +
                currencyName.toLowerCase() +
                '&order=market_cap_desc&per_page=100&page=1&sparkline=false');
        final data = jsonDecode(response.body);

        String name = data[0]['name'].toString();
        String imgSrc = data[0]['image'].toString();
        String usdMarketShare = data[0]['market_cap'].toString();
        String usdPrice = data[0]['current_price'].toString();
        return CryptoCurrency(
            name: name,
            imgSrc: imgSrc,
            usdMarketShare: usdMarketShare,
            usdPrice: usdPrice);
      } catch (e) {
        print(e);
        return null;
      }
    }
  }
}
