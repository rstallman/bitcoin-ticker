import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/components/coin_card.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  List<String> rates = cryptoList.map((c) => '1 $c = ? USD').toList();

  List<Widget> getChildrenWidgets() {
    List<Widget> res = [];

    for (String rate in rates) {
      res.add(CoinCard(rate));
    }

    res.add(Container(
      height: 150.0,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 30.0),
      color: Colors.lightBlue,
      child: Platform.isIOS ? iosPicker() : androidDropDown(),
    ));

    return res;
  }

  DropdownButton<String> androidDropDown() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currenciesList
          .map((c) => DropdownMenuItem(
                value: c,
                child: Text(c),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedCurrency = value!;
          getExchangeRateData(selectedCurrency);
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    return CupertinoPicker(
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getExchangeRateData(selectedCurrency);
        });
      },
      children: currenciesList.map((c) => Text(c)).toList(),
    );
  }

  void getExchangeRateData(String currency) async {
    var coinData = CoinData();
    List<String> exchangeRates = [];

    for (String crypto in cryptoList) {
      var exchangeRateData = await coinData.getExchangeRate(crypto, currency);
      if (exchangeRateData == null) return;
      double rate = exchangeRateData['rate'];
      exchangeRates.add('1 $crypto = ${rate.toStringAsFixed(2)} $currency');
    }

    setState(() {
      rates = exchangeRates;
    });
  }

  @override
  void initState() {
    super.initState();
    getExchangeRateData('USD');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: getChildrenWidgets(),
      ),
    );
  }
}
