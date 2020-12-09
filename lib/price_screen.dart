import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String btcPrice;
  String ethPrice;
  String ltcPrice;

  Widget androidMenu() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String cur in currenciesList) {
      var newitem = DropdownMenuItem(
        child: Text(cur),
        value: cur,
      );
      dropdownItems.add(newitem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value;
            getData();
          });
        });
  }

  Widget iosMenu() {
    List<Text> items = [];
    for (String cur in currenciesList) {
      var newitem = Text(cur);
      items.add(newitem);
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: items,
    );
  }

  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCryptoprice(selectedCurrency);
      isWaiting = false;
      setState(() {
        btcPrice = data[0];
        ethPrice = data[1];
        ltcPrice = data[2];
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget cryptoCard(String crypto, String cryptoPrice, String currency) {
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
        child: Text(
          '1 $crypto = $cryptoPrice $currency',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: cryptoCard('BTC', btcPrice, selectedCurrency)),
              Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: cryptoCard('ETH', ethPrice, selectedCurrency)),
              Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: cryptoCard('LTC', ltcPrice, selectedCurrency)),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosMenu() : androidMenu(),
          ),
        ],
      ),
    );
  }
}
