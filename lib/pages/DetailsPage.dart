import 'package:crypto_tracker/models/cryptocurrency.dart';
import 'package:crypto_tracker/provider/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;

  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget titleAndDetail(
      String title, String detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        Text(
          detail,
          style: TextStyle(fontSize: 17),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Consumer<MarketProvider>(
            builder: (context, marketProvider, child) {
              CryptoCurrency currentCrypto =
                  marketProvider.fetchCryptoById(widget.id);
              return RefreshIndicator(
                onRefresh: () async { await marketProvider.fetchData();},
                child: ListView(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(currentCrypto.image!),
                      ),
                      title: Text(
                        currentCrypto.name! +
                            " (${currentCrypto.symbol!.toUpperCase()})",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        "₹ " + currentCrypto.current_price!.toStringAsFixed(4),
                        style: TextStyle(fontSize: 20),
                      ),
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Price Change (24h)",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Builder(builder: (context) {
                          double priceChange = currentCrypto.price_change_24h!;
                          double priceChangePercentage =
                              currentCrypto.price_change_percentage_24h!;

                          if (priceChange < 0) {
                            return Text(
                              "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            );
                          } else {
                            return Text(
                              "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 20,
                              ),
                            );
                          }
                        }),
                      ],
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "Market Cap",
                            "₹ " + currentCrypto.market_cap!.toStringAsFixed(4),
                            CrossAxisAlignment.start),
                        titleAndDetail(
                            "Market Cap Rank",
                            "# " + currentCrypto.market_cap_rank!.toString(),
                            CrossAxisAlignment.end),
                      ],
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "Low 24h",
                            "₹ " + currentCrypto.low_24h!.toStringAsFixed(4),
                            CrossAxisAlignment.start),
                        titleAndDetail(
                            "High 24h",
                            "₹ " + currentCrypto.high_24h!.toStringAsFixed(4),
                            CrossAxisAlignment.end),
                      ],
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "Circulating Supply",
                            currentCrypto.circulating_supply!.toInt().toString(),
                            CrossAxisAlignment.start),
                      ],
                    ),

                    SizedBox(
                      height: 30,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleAndDetail(
                            "All Time Low",
                            currentCrypto.atl!.toInt().toStringAsFixed(4),
                            CrossAxisAlignment.start),
                        titleAndDetail(
                            "All Time High",
                            currentCrypto.ath!.toInt().toStringAsFixed(4),
                            CrossAxisAlignment.start),
                      ],
                    ),

                    // Text(currentCrypto.name!),
                  ],
                ),
              );
            },
          ),

          // child: ListView(
          //   children: [],
          // ),
        ),
      ),
    );
  }
}
