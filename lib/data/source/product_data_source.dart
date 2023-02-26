import 'package:dio/dio.dart';
import 'package:nikestore/common/exception.dart';
import 'package:nikestore/common/http_response_validator.dart';
import 'package:nikestore/data/product.dart';

abstract class IProductDataSource {
  Future<List<ProductEntity>> getall(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRemoteDataSource with HttpResponseValidator implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSource(this.httpClient);
  @override
  Future<List<ProductEntity>> getall(int sort) async {
    final response = await httpClient.get("product/list?sort=$sort");
    validateResponse(response);
    final List<ProductEntity> products = [];
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromjson(element));
    });
    return products;
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) async{
    final response = await httpClient.get("product/search?q=$searchTerm");
    validateResponse(response);
    final List<ProductEntity> products = [];
    (response.data as List).forEach((element) {
      products.add(ProductEntity.fromjson(element));
    });
    return products;
  }
}


