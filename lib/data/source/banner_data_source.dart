import 'package:dio/dio.dart';
import 'package:nikestore/common/http_response_validator.dart';
import 'package:nikestore/data/banner.dart';
import 'package:nikestore/data/source/product_data_source.dart';

abstract  class IBannerDataSource{
  Future<List<BannerEntity>> getall();
} 

class BannerRemotDataSource with HttpResponseValidator implements IBannerDataSource{
  final Dio httpClient;

  BannerRemotDataSource(this.httpClient);
  @override
  Future<List<BannerEntity>> getall() async{
    final response=await httpClient.get("banner/slider");
    validateResponse(response);
    final List<BannerEntity> banners=[];
    (response.data as List).forEach((element) { 
      banners.add(BannerEntity.fromjson(element));
    });
    return banners;

  }
  

}