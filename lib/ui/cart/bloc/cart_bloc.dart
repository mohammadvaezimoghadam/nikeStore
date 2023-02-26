import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nikestore/common/exception.dart';
import 'package:nikestore/data/autinfo.dart';
import 'package:nikestore/data/cart_response.dart';
import 'package:nikestore/data/repo/cart_repository.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final ICartRepository repository;
  CartBloc(this.repository) : super(CartLoading()) {
    on<CartEvent>((event, emit)async {
      if (event is CartStarted) {
        final authInfo=event.authInfo;
        if(authInfo==null || authInfo.accessToken.isEmpty){
          emit(CartAuthRequired());
        }else {
         getList(event.isRefreshing);

        }
        

      }else if(event is CartAuthInfoChanged){
        if(event.authInfo==null || event.authInfo!.accessToken.isEmpty){
          emit(CartAuthRequired());

        }else{
          if(state is CartAuthRequired){
            getList(false);
            
          }
        }

      }else if(event is CartDeleteBtnClicked){
         try{
          if(state is CartSaccess){
            final successState=(state as CartSaccess);
            final index = successState.cartResponse.cartItems
                .indexWhere((element) => element.id == event.cartItemId);
            successState.cartResponse.cartItems[index].deleteBtnLoading=true; 
            emit(CartSaccess(successState.cartResponse));   

          }
          
          await repository.delete(event.cartItemId);
          if(state is CartSaccess){
            final successState=(state as CartSaccess);
            
            successState.cartResponse.cartItems.removeWhere((element) => element.id==event.cartItemId);
            if(successState.cartResponse.cartItems.isEmpty){
              emit(EmptyState());
            }else{
              emit(caculatePriceInfo(successState.cartResponse));

            } 
               

          }
         }catch(e){
          emit(CartError(AppException()));
         }
      }else if(event is IncreaseCountBtnClicked || event is DecreaseCountBtnClicked){
        try{
          int cartItemId=0;
          if(event is IncreaseCountBtnClicked){
            cartItemId=event.cartItemId;
          }else if(event is DecreaseCountBtnClicked){
            cartItemId=event.cartItemId;
          }
          if(state is CartSaccess){
            final successState=(state as CartSaccess);
            final index = successState.cartResponse.cartItems
                .indexWhere((element) => element.id == cartItemId);
            successState.cartResponse.cartItems[index].chengeCountLoadig=true; 
            emit(CartSaccess(successState.cartResponse));   

          
            final newCount = event is IncreaseCountBtnClicked
                ? ++successState.cartResponse.cartItems[index].count 
                : --successState.cartResponse.cartItems[index].count ;
            await repository.changeCount(cartItemId, newCount);
          
            
            successState.cartResponse.cartItems
                .firstWhere((element) => element.id == cartItemId)
                ..count = newCount
                ..chengeCountLoadig=false;
            
              emit(caculatePriceInfo(successState.cartResponse));

             
               

          
          }
         }catch(e){
          emit(CartError(AppException()));
         }
         

      }
      

      
    });
  }
  Future<void> getList(bool isRefreshing) async{
    try {
      if(isRefreshing==false){
        emit(CartLoading());

      }
      
      final response = await repository.getall();
      if(response.cartItems.isNotEmpty){
        emit(CartSaccess(response));

      }else{
        emit(EmptyState());
      }
      
    } catch (e) {
      emit(CartError(AppException()));
        }


  }
 CartSaccess caculatePriceInfo(CartResponse cartResponse){
    int totalPrice = 0;
    int payablePrice = 0;
    int shippingPrice = 0;
    cartResponse.cartItems.forEach((cartItem) {
      totalPrice+=cartItem.productEntity.previousPrice * cartItem.count;
      payablePrice+=cartItem.productEntity.price*cartItem.count;
      shippingPrice=payablePrice>250000?0:30000;
    });
    cartResponse.totalPrice=totalPrice;
    cartResponse.payablePrice=payablePrice;
    cartResponse.shippingCost=shippingPrice;

    return CartSaccess(cartResponse);


  }
}

 
