class CryptoCurrency {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? current_price;
  double? market_cap;
  int? market_cap_rank;
  double? high_24h;
  double? low_24h;
  double? price_change_24h;
  double? price_change_percentage_24h;
  double? circulating_supply;
  double? ath;
  double? atl;
  bool isFavourite = false;

  CryptoCurrency(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.image,
      required this.current_price,
      required this.market_cap,
      required this.market_cap_rank,
      required this.high_24h,
      required this.low_24h,
      required this.price_change_24h,
      required this.price_change_percentage_24h,
      required this.circulating_supply,
      required this.ath,
      required this.atl});

  factory CryptoCurrency.fromJSON(Map<String, dynamic> map) {
    return CryptoCurrency(
        id: map["id"],
        symbol: map["symbol"],
        name: map["name"],
        image: map["image"],
        current_price: double.parse(map["current_price"].toString()),
        market_cap: double.parse(map["market_cap"].toString()),
        market_cap_rank: map["market_cap_rank"],
        high_24h: double.parse(map["high_24h"].toString()),
        low_24h: double.parse(map["low_24h"].toString()),
        price_change_24h: double.parse(map["price_change_24h"].toString()),
        price_change_percentage_24h: double.parse(map["price_change_percentage_24h"].toString()),
        circulating_supply: double.parse(map["circulating_supply"].toString()),
        ath: double.parse(map["ath"].toString()),
        atl: double.parse(map["atl"].toString()));
  }
}
