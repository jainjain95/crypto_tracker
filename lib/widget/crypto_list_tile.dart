import 'package:crypto/models/crypto_info.dart';
import 'package:crypto/pages/detail_page.dart';
import 'package:crypto/provider/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoListTile extends StatelessWidget {
  const CryptoListTile({Key? key, required this.currentCrypto})
      : super(key: key);
  final CryptoInfo currentCrypto;

  @override
  Widget build(BuildContext context) {
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailPage(
                    id: currentCrypto.id!,
                  )),
        );
      },
      contentPadding: EdgeInsets.all(0),
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(currentCrypto.image!),
      ),
      title: Row(
        children: [
          Flexible(
              child: Text(
            currentCrypto.name!,
            overflow: TextOverflow.ellipsis,
          )),
          SizedBox(
            width: 10,
          ),
          (currentCrypto.isFavorite == false)
              ? GestureDetector(
                  onTap: () {
                    marketProvider.addFavorites(currentCrypto);
                  },
                  child: Icon(
                    CupertinoIcons.circle,
                    size: 15,
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    marketProvider.removeFavorites(currentCrypto);
                  },
                  child: Icon(
                    CupertinoIcons.circle_fill,
                    size: 15,
                    color: Colors.yellow,
                  ),
                ),
        ],
      ),
      subtitle: Text(currentCrypto.symbol!.toUpperCase()),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "₹ " + currentCrypto.currentPrice!.toStringAsFixed(3),
            style: TextStyle(
              color: Color(0xff0395eb),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Builder(builder: (context) {
            double priceChange = currentCrypto.priceChange24!;
            double priceChangePercentage =
                currentCrypto.priceChangePercentage24!;
            if (priceChange < 0) {
              //negative
              return Text(
                "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(3)})",
                style: TextStyle(
                  color: Colors.red,
                ),
              );
            } else {
              //positive
              return Text(
                "+${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(3)})",
                style: TextStyle(
                  color: Colors.green,
                ),
              );
            }
          })
        ],
      ),
    );
  }
}
