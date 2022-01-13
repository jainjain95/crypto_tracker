import 'package:crypto/models/crypto_info.dart';
import 'package:crypto/provider/market_provider.dart';
import 'package:crypto/widget/crypto_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favorites extends StatefulWidget {
  const Favorites({ Key? key }) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        List<CryptoInfo> fav = marketProvider.markets.where((element) => element.
        isFavorite == true).toList();

        if(fav.length > 0){
          return ListView.builder(
          itemCount: fav.length,
          itemBuilder: (context, index) {
            CryptoInfo currentCryptor = fav[index];
            return CryptoListTile(currentCrypto: currentCryptor);
          }
        );
      }
      else{
        return Center(
          child: Text("No Favorites", style: TextStyle(color: Colors.grey,),)
        );
      }}
      );
      
      
  }
}