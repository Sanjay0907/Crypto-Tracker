import 'package:crypto_tracker/models/cryptocurrency.dart';
import 'package:crypto_tracker/pages/DetailsPage.dart';
import 'package:crypto_tracker/provider/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoListtile extends StatelessWidget {
  // const CryptoListtile({Key? key}) : super(key: key);

  final CryptoCurrency currentCrypto;

  const CryptoListtile({Key? key, required this.currentCrypto}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    MarketProvider marketProvider = Provider.of<MarketProvider> (context, listen: false);

    return ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsPage(
              id: currentCrypto.id!,
            ),
          ),
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
            ),
          ),
          SizedBox(
            width: 10,
          ),


          (currentCrypto.isFavourite == false) ? GestureDetector(
            onTap: () {
              marketProvider.addFavourite(currentCrypto);
            },
            child: Icon(
              CupertinoIcons.heart,
              size: 20,
            ),
          ) : GestureDetector(
            onTap: () {
              marketProvider.removeFavourite(currentCrypto);
            },
            child: Icon(
              CupertinoIcons.heart_fill,
              size: 20,
              color: Colors.redAccent,
            ),
          )
        ],
      ),
      subtitle: Text(currentCrypto.symbol!.toUpperCase()),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "₹ " +
                currentCrypto.current_price!.toStringAsFixed(3),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff0395eb),
              fontSize: 18,
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
                ),
              );
            } else {
              return Text(
                "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
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
