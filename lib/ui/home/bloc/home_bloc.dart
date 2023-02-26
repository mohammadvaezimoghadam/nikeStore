import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nikestore/common/exception.dart';
import 'package:nikestore/data/banner.dart';
import 'package:nikestore/data/product.dart';
import 'package:nikestore/data/repo/banner_repository.dart';
import 'package:nikestore/data/repo/product_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository bannerRepository;
  final IProductRepsitory productRepsitory;
  HomeBloc({required this.bannerRepository, required this.productRepsitory})
      : super(HomeLoading()) {
    on<HomeEvent>((event, emit) async {
      if (event is HomeStarted || event is HomeRefresh) {
        try {
          emit(HomeLoading());
          final banners = await bannerRepository.getall();
          final latestProducts =
              await productRepsitory.getall(ProductSort.latest);
          final popularProducts =
              await productRepsitory.getall(ProductSort.popular);

          emit(HomeSuccess(
              banners: banners,
              latestProducts: latestProducts,
              popularProducts: popularProducts));
        } catch (e) {
          emit(HomeError(exception: e is AppException?e:AppException()));
        }
      }
    });
  }
}
