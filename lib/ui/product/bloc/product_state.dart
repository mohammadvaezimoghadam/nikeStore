part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductAddToCartBtnLoading extends ProductState{

}
class ProductAddToCartError extends ProductState{
  final AppException exception;

  const ProductAddToCartError(this.exception);
  @override
  // TODO: implement props
  List<Object> get props => [exception];
}
class ProductAddToCartSuccess extends ProductState{
  
}
