import 'package:crypto/models/crypto_info.dart';
import 'package:crypto/provider/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  final String id;
  const DetailPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

  Widget titleAndDetail(String title, String detail, CrossAxisAlignment crossAxisAlignment){
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(title, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
        Text(detail,  style: TextStyle(fontSize: 14)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child:
        Consumer<MarketProvider>(builder: (context, marketProvider, child) {
      CryptoInfo currentCrypto = marketProvider.fetchCryptoById(widget.id);
      return Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right:20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(currentCrypto.image!),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${currentCrypto.name!} (${currentCrypto.symbol!.toUpperCase()})",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "₹ " +
                                currentCrypto.currentPrice!.toStringAsFixed(3),
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Price Change (24hr)",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 2),
              Builder(builder: (context) {
                double priceChange = currentCrypto.priceChange24!;
                double priceChangePercentage =
                    currentCrypto.priceChangePercentage24!;
                if (priceChange < 0) {
                  //negative
                  return Text(
                    "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(3)})",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                    ),
                  );
                } else {
                  //positive
                  return Text(
                    "+${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(3)})",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                    ),
                  );
                }
              }),
              SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleAndDetail("High 24h", "₹ " + currentCrypto.high24!.toStringAsFixed(3),
                  CrossAxisAlignment.start),
                  titleAndDetail("Low 24h", "₹ " + currentCrypto.low24!.toStringAsFixed(3),
                  CrossAxisAlignment.end),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleAndDetail("All Time Low", "₹ " + currentCrypto.ath!.toStringAsFixed(3),
                  CrossAxisAlignment.start),
                  titleAndDetail("All Time High", "₹ " + currentCrypto.atl!.toStringAsFixed(3),
                  CrossAxisAlignment.end),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  titleAndDetail("Market Cap", "₹ " + currentCrypto.marketCap!.toString(),
                  CrossAxisAlignment.start),
                  titleAndDetail("Circulating Supply", currentCrypto.circulatingSupply!.toString(),
                  CrossAxisAlignment.end),
                ],
              ),
            ],
          ),
        ),
      );
    }));
  }
}
