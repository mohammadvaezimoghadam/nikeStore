import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nikestore/common/exception.dart';
import 'package:nikestore/data/repo/cart_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ICartRepository repository;
  ProductBloc(this.repository) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is CartAddBtnClicked) {
        try{
          emit(ProductAddToCartBtnLoading());
        await repository.add(event.productId);
        emit(ProductAddToCartSuccess());
        }catch(e){
          emit(ProductAddToCartError(AppException()));
        }

      }
    });
  }
}
