import 'package:helloworld/services/networking.dart';

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
  'DOG',
  'XRP',
];

const apiKey = '47D114C3-0713-44B7-B73F-C47E10CC27D6';
const coinApiHost = 'rest.coinapi.io';
const coinApiPath = '/v1/exchangerate';

class CoinData {

  Future<dynamic> getExchangeRate(String crypto, String currency) async {
    Uri url = Uri.https(coinApiHost, '$coinApiPath/$crypto/$currency', {
      'apikey': apiKey,
    });

    return await NetworkHelper(url).getData();
  }


}
