part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}
class CartStarted extends CartEvent{
  final AuthInfo? authInfo;
  final bool isRefreshing;

  CartStarted(this.authInfo, {this.isRefreshing=false});
  
  @override
  // TODO: implement props
  List<Object> get props => [authInfo!];

  
}

class CartAuthInfoChanged extends CartEvent{
  final AuthInfo? authInfo;

  const CartAuthInfoChanged(this.authInfo);
  
  @override
  // TODO: implement props
  List<Object> get props => [authInfo!];
  
}
class IncreaseCountBtnClicked extends CartEvent{
  final int cartItemId;

  IncreaseCountBtnClicked(this.cartItemId);
  @override
  // TODO: implement props
  List<Object> get props => [cartItemId];
}
class DecreaseCountBtnClicked extends CartEvent{
  final int cartItemId;

  DecreaseCountBtnClicked(this.cartItemId);
  @override
  // TODO: implement props
  List<Object> get props => [cartItemId];
}
class CartDeleteBtnClicked extends CartEvent{
  final int cartItemId;

  CartDeleteBtnClicked(this.cartItemId);
  @override
  // TODO: implement props
  List<Object> get props => [cartItemId];

  
  
}
