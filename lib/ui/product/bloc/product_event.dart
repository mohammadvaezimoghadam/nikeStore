part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class CartAddBtnClicked extends ProductEvent {
  
  final int productId;

  const CartAddBtnClicked(this.productId);
  @override
  // TODO: implement props
  List<Object> get props => [productId];
}
