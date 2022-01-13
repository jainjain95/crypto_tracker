
import 'dart:async';

import 'package:crypto/models/api.dart';
import 'package:crypto/models/crypto_info.dart';
import 'package:crypto/models/localStorage.dart';
import 'package:flutter/foundation.dart';

class MarketProvider with ChangeNotifier {

  bool isLoading = true;
  List<CryptoInfo> markets = [];
  MarketProvider(){
    fetchData();
  }

  Future<void> fetchData() async {
    List<dynamic> _markets = await Api.getMarkets();
    List<String> favorites = await LocalStorage.fetchFavorites();

    List<CryptoInfo> temp =[];
    for(var market in _markets){
      CryptoInfo newCrypto = CryptoInfo.fromJSON(market);
      if(favorites.contains(newCrypto.id!)){
        newCrypto.isFavorite = true;
      }
      temp.add(newCrypto);
    }
    markets = temp;
    isLoading = false;
    notifyListeners(); 
    Timer( const Duration(seconds: 3),() {
      fetchData();
    });
  }

  CryptoInfo fetchCryptoById(String id){
    CryptoInfo crypto = markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }

  void addFavorites(CryptoInfo crypto) async {
    int index = markets.indexOf(crypto);
    markets[index].isFavorite = true;
    await LocalStorage.addFavorite(crypto.id!);
    notifyListeners();
  }
  void removeFavorites(CryptoInfo crypto) async {
    int index = markets.indexOf(crypto);
    markets[index].isFavorite = false;
    await LocalStorage.removeFavorite(crypto.id!);
    notifyListeners();
  }
}