import 'package:dio/dio.dart';
import 'package:nikestore/common/http_client.dart';
import 'package:nikestore/data/cart_item.dart';
import 'package:nikestore/data/add_to_cart_response.dart';
import 'package:nikestore/data/cart_response.dart';
import 'package:nikestore/data/source/cart_data_sorce.dart';

final cartRepository = CartRepository(CartRemoteDataSoutce(httpClient));

abstract class ICartRepository {
  Future<AddToCartResponse> add(int productId);
  Future<AddToCartResponse> changeCount(int cartItemId, int count);
  Future<void> delete(int cartItemId);
  Future<int> count();
  Future<CartResponse> getall();
}

class CartRepository implements ICartRepository {
  final ICartDataSource dataSource;

  CartRepository(this.dataSource);
  @override
  Future<AddToCartResponse> add(int productId) async => dataSource.add(productId);

  @override
  Future<AddToCartResponse> changeCount(int cartItemId, int count) {
    return dataSource.changeCount(cartItemId, count);
  }

  @override
  Future<int> count() {
    // TODO: implement count
    throw UnimplementedError();
  }

  @override
  Future<void> delete(int cartItemId) async{
    await dataSource.delete(cartItemId);
  }

  @override
  Future<CartResponse> getall() {
    return dataSource.getall();
  }
}
