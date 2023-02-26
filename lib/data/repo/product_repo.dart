import 'package:dio/dio.dart';
import 'package:nikestore/common/http_client.dart';
import 'package:nikestore/data/product.dart';
import 'package:nikestore/data/source/product_data_source.dart';


final productRepository =
    ProductRepository(ProductRemoteDataSource(httpClient));

abstract class IProductRepsitory {
  Future<List<ProductEntity>> getall(int sort);
  Future<List<ProductEntity>> search(String searchTerm);
}

class ProductRepository implements IProductRepsitory {
  final IProductDataSource dataSource;

  ProductRepository(this.dataSource);
  @override
  Future<List<ProductEntity>> getall(int sort) {
    return dataSource.getall(sort);
  }

  @override
  Future<List<ProductEntity>> search(String searchTerm) {
    return dataSource.search(searchTerm);
  }
}
