import 'networking.dart';

const apikey = '3cc063c71ce5548ad341c2b717dc33e7';
const apiurl = 'https://api.nomics.com/v1/currencies/ticker';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  String btcPrice;
  String ethPrice;
  String ltcPrice;
  Future getCryptoprice(String currency) async {
    var url =
        '$apiurl?key=$apikey&ids=BTC,ETH,LTC&interval=1d,30d&convert=$currency';
    NetworkHelper networkHelper = NetworkHelper(url);
    var price = await networkHelper.getData();
    var btc = price[0]['price'];
    btcPrice = double.parse(btc).toStringAsFixed(2);
    var eth = price[1]['price'];
    ethPrice = double.parse(eth).toStringAsFixed(2);
    var ltc = price[2]['price'];
    ltcPrice = double.parse(ltc).toStringAsFixed(2);
    return [btcPrice, ethPrice, ltcPrice];
  }
}
