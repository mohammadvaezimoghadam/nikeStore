import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nikestore/common/utils.dart';
import 'package:nikestore/data/autinfo.dart';
import 'package:nikestore/data/cart_item.dart';
import 'package:nikestore/data/repo/auth_repository.dart';
import 'package:nikestore/data/repo/cart_repository.dart';
import 'package:nikestore/ui/auth/auth.dart';
import 'package:nikestore/ui/cart/bloc/cart_bloc.dart';
import 'package:nikestore/ui/cart/cart_items.dart';
import 'package:nikestore/ui/cart/price_info.dart';
import 'package:nikestore/ui/widgets/empty_state.dart';

import 'package:nikestore/ui/widgets/image.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartBloc? cartBloc;
 final RefreshController _refreshController=RefreshController();
  StreamSubscription<CartState>? streamSubscription; 
  @override
  void initState() {
    
    super.initState();
    AuthRepository.authChangeNotifire.addListener(authChengeNotifierListener);

  }
  @override
  void dispose() {
    AuthRepository.authChangeNotifire.removeListener(authChengeNotifierListener);
    streamSubscription?.cancel();
    cartBloc?.close();
    super.dispose();
  }
  void authChengeNotifierListener(){
    cartBloc?.add(CartAuthInfoChanged(AuthRepository.authChangeNotifire.value));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('سبد خرید'),),
      body:BlocProvider<CartBloc>(create: (context) {
        final bloc= CartBloc(cartRepository);
        cartBloc =bloc;
        streamSubscription=bloc.stream.listen((state) {
          if(state is CartSaccess && _refreshController.isRefresh){
            _refreshController.refreshCompleted();
          }else if(state is CartError){
            _refreshController.refreshFailed();
          }
          
        });
        bloc.add(CartStarted(AuthRepository.authChangeNotifire.value));
        return bloc ;
      },
      child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if(state is CartLoading){
          return Center(
            child: CupertinoActivityIndicator(),
          );}
        else if(state is CartError){
          return Center(
            child: Text(state.exception.message),
          );}

         else if (state is CartSaccess) {
          return SmartRefresher(
            
            controller:_refreshController ,
            onRefresh: (){
              cartBloc?.add(CartStarted(AuthRepository.authChangeNotifire.value,isRefreshing: true));
            },
            child: ListView.builder(
              physics: difaultScrollPhy,
              itemBuilder: (context, index) {
                if(index<state.cartResponse.cartItems.length){
                  final data=state.cartResponse.cartItems[index];
                return Cart_items(data: data,onDeleteBtnClicked: (){
                  cartBloc?.add(CartDeleteBtnClicked(data.id));
                },
                    onIncreaseBtnClicked: () {
                      cartBloc?.add(IncreaseCountBtnClicked(data.id));
                    },
                    onDecreaseBtnClicked: () {
                      if(data.count>1){
                        cartBloc?.add(DecreaseCountBtnClicked(data.id));
                      }
                    },
                  );

                }else {
                  return PriceInfo(payablePrice: state.cartResponse.payablePrice,
                  totalOrice: state.cartResponse.totalPrice,
                  shippingPrice: state.cartResponse.shippingCost,) ;
                }
                
              
            
              },
            itemCount: state.cartResponse.cartItems.length+1,),
          );}
         else if (state is CartAuthRequired) {
          return EmptyView(message: 'برای مشاهده سبد خرید ابتدا وارد حساب کار بری شوید', callToAction: ElevatedButton(onPressed: (){
                    Navigator.of(context,rootNavigator: true).push(MaterialPageRoute(builder: (context)=> AuthScreen()));
                  },
                  child: Text('ورود')),
              image: SvgPicture.asset(
                "assets/img/auth_required.svg",
                width: 140,
              ));}
         else if (state is EmptyState) {
          return EmptyView(message: 'تا کنون هیچ محصولی به سبد خرید اضافه نکرده اید',
              image: SvgPicture.asset(
                "assets/img/empty_cart.svg",
                width: 200,
              ));
        }

        else {
          throw Exception("state not valid");
        }

      })),
    );
      // ValueListenableBuilder<AuthInfo?>(
      //   valueListenable: AuthRepository.authChangeNotifire,
      //   builder: (context, value, child) {
      //     bool isAuthenticated = value != null && value.accessToken.isNotEmpty;
      //     return SizedBox(
      //       width: MediaQuery.of(context).size.width,
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           Text(isAuthenticated
      //               ? 'خوش آمدید'
      //               : 'وارد حساب کاربری خود شوید'),
      //           isAuthenticated
      //               ? ElevatedButton(
      //                   onPressed: () {
      //                     authRepository.signOut();
      //                   },
      //                   child: Text('خروج از حساب'),
      //                 )
      //               : ElevatedButton(
      //                   onPressed: () {
      //                     Navigator.of(context, rootNavigator: true).push(
      //                         MaterialPageRoute(
      //                             builder: (context) => AuthScreen()));
      //                   },
      //                   child: Text('وارد حساب کاربری خود شوید'),
      //                 )
      //         ],
      //       ),
      //     );
      //   },
      // ),
    
  }
}

