import 'dart:async';
import 'package:crypto_tracker/models/LocalStorage.dart';
import 'package:crypto_tracker/models/cryptocurrency.dart';
import 'package:flutter/cupertino.dart';
import 'package:crypto_tracker/models/API.dart';

class MarketProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrency> markets = [];

  MarketProvider(){
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> _markets = await API.getMarkets();
    List<String> favourites = await LocalStorage.fetchFavourites();

    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);

      if (favourites.contains(newCrypto.id!)){
        newCrypto.isFavourite = true;
      }
      temp.add(newCrypto);
    }

    markets = temp;
    isLoading = false;
    notifyListeners();
    
    Timer(const Duration(seconds: 2), (){
      fetchData();
      // print("Data Updated");
    });
  }

  CryptoCurrency fetchCryptoById(String id) {
    CryptoCurrency crypto = markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }


  void addFavourite(CryptoCurrency crypto) async {
    int indexofCrypto = markets.indexOf(crypto);
    markets[indexofCrypto].isFavourite = true;
    await LocalStorage.addFavourite(crypto.id!);
    notifyListeners();
  }

  void removeFavourite(CryptoCurrency crypto) async {
    int indexofCrypto = markets.indexOf(crypto);
    markets[indexofCrypto].isFavourite = false;
    await LocalStorage.removeFavourite(crypto.id!);
    notifyListeners();
  }
}
