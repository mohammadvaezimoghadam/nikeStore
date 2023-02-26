import 'package:dio/dio.dart';
import 'package:nikestore/common/http_response_validator.dart';
import 'package:nikestore/data/cart_item.dart';
import 'package:nikestore/data/add_to_cart_response.dart';
import 'package:nikestore/data/cart_response.dart';

abstract class ICartDataSource {
  Future<AddToCartResponse> add(int productId);
  Future<AddToCartResponse> changeCount(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<CartResponse> getall();
}

class CartRemoteDataSoutce
    with HttpResponseValidator
    implements ICartDataSource {
  final Dio httpClient;

  CartRemoteDataSoutce(this.httpClient);
  @override
  Future<AddToCartResponse> add(int productId) async {
    final response =
        await httpClient.post("cart/add", data: {"product_id": productId});
    validateResponse(response);
    return AddToCartResponse.fromJson(response.data);
  }

  @override
  Future<AddToCartResponse> changeCount(int cartItemId, int count) async{
    final response= await httpClient.post('cart/changeCount',data: {
    'cart_item_id': cartItemId,
     'count': count
    }); 

    return AddToCartResponse.fromJson(response.data);
    
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int cartItemId) async{
    
   await httpClient.post('cart/remove',data:{
      'cart_item_id':cartItemId
    });
  }

  @override
  Future<CartResponse> getall() async{
    final response=await httpClient.get("cart/list");
    validateResponse(response);
    final cartResponse=CartResponse.fromJson(response.data);
    return cartResponse;



  }
}
