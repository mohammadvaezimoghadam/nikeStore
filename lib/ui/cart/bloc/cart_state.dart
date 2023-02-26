part of 'cart_bloc.dart';

abstract class CartState {
  const CartState();
  
  
}

class CartLoading extends CartState {}


class CartSaccess extends CartState{
  final CartResponse cartResponse;

  CartSaccess(this.cartResponse);
  

}

class CartError extends CartState{
  final AppException exception;

  CartError(this.exception);
  


}
class CartAuthRequired extends CartState{
  
}
class EmptyState extends CartState{
  
}