class ProductSort{
  static const int latest=0;
  static const int popular=1;
  static const int priceHighToLow=2; 
  static const int priceLowToHigh=3; 
}
class ProductEntity {
  int id;
  String title;
  String imageUrl;
  int price;
  int previousPrice;
  int discount;

  ProductEntity.fromjson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        imageUrl = json["image"],
        price = json["price"],
        previousPrice = json["previous_price"]??json["price"]+json['discount'],
        discount = json["discount"];
}
