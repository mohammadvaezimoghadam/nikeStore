import 'package:nikestore/data/cart_item.dart';

class CartResponse{
  final List<CartItemsEntity> cartItems;
   int payablePrice;
   int totalPrice;
   int shippingCost;

  CartResponse.fromJson(Map<String, dynamic> json)
      : cartItems = CartItemsEntity.parseJsonArray(json["cart_items"]),
        payablePrice = json["payable_price"],
        totalPrice = json["total_price"],
        shippingCost = json["shipping_cost"];
  
}