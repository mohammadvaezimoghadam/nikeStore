import 'package:nikestore/common/http_client.dart';
import 'package:nikestore/data/banner.dart';
import 'package:nikestore/data/source/banner_data_source.dart';

final bannerRepository = BannerRipository(BannerRemotDataSource(httpClient));

abstract class IBannerRepository {
  Future<List<BannerEntity>> getall();
}

class BannerRipository implements IBannerRepository {
  final IBannerDataSource dataSource;

  BannerRipository(this.dataSource);
  @override
  Future<List<BannerEntity>> getall() {
    return dataSource.getall();
  }
}
