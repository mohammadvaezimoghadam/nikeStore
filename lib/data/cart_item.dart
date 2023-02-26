import 'package:nikestore/data/product.dart';

class CartItemsEntity {
  final ProductEntity productEntity;
  final int id;
   int count;
  bool deleteBtnLoading=false;
  bool chengeCountLoadig=false;

  CartItemsEntity.fromJson(Map<String, dynamic> json)
      : productEntity = ProductEntity.fromjson(json['product']),
        id = json["cart_item_id"],
        count = json["count"];

        static List<CartItemsEntity> parseJsonArray(List<dynamic> jsonArray){
          final List<CartItemsEntity> items=[];
          jsonArray.forEach((element) {
            items.add(CartItemsEntity.fromJson(element));
          });
          return items;

        }
}
