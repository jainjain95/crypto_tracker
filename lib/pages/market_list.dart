import 'package:crypto/models/crypto_info.dart';
import 'package:crypto/pages/detail_page.dart';
import 'package:crypto/provider/market_provider.dart';
import 'package:crypto/widget/crypto_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Market extends StatefulWidget {
  const Market({Key? key}) : super(key: key);

  @override
  _MarketState createState() => _MarketState();
}

class _MarketState extends State<Market> {
  @override
  Widget build(BuildContext context) {
    var consumer = Consumer<MarketProvider>(
      builder: (context, marketProvider, child) {
        if (marketProvider.isLoading == true) {
          return Center(child: CircularProgressIndicator());
        } else {
          if (marketProvider.markets.length > 0) {
            return RefreshIndicator(
              onRefresh: () async {
                await marketProvider.fetchData();
              },
              child: ListView.builder(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: marketProvider.markets.length,
                  itemBuilder: (context, index) {
                    CryptoInfo currentCrypto = marketProvider.markets[index];
                    return CryptoListTile(currentCrypto: currentCrypto);
                    
                  }
              ),
            );
          } else {
            return Text(" data not found");
          }
        }
      },
    );
    

    return consumer;
  }
}
