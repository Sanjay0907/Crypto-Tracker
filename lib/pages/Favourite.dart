import 'package:crypto_tracker/Widgets/CryptoListTile.dart';
import 'package:crypto_tracker/models/cryptocurrency.dart';
import 'package:crypto_tracker/provider/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MarketProvider>(builder: (context, marketProvider, child) {
      List<CryptoCurrency> favourites = marketProvider.markets
          .where((element) => element.isFavourite == true)
          .toList();

      if (favourites.length > 0) {
        return ListView.builder(
          itemCount: favourites.length,
          itemBuilder: (context, index) {
            CryptoCurrency currentCrypto = favourites[index];
            return CryptoListtile(currentCrypto: currentCrypto);
          },
        );
      } else {
        return Center(
          child: Text(
            "No Favourites added",
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        );
      }
    });
  }
}
