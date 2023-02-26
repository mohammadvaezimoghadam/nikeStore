import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nikestore/common/utils.dart';
import 'package:nikestore/data/cart_item.dart';
import 'package:nikestore/ui/cart/bloc/cart_bloc.dart';
import 'package:nikestore/ui/widgets/image.dart';

class Cart_items extends StatelessWidget {
  const Cart_items({
    Key? key,
    required this.data, required this.onDeleteBtnClicked, required this.onIncreaseBtnClicked, required this.onDecreaseBtnClicked,
    
  }) : super(key: key);

  final CartItemsEntity data;
  final GestureTapCallback onDeleteBtnClicked;
  final GestureTapCallback onIncreaseBtnClicked;
  final GestureTapCallback onDecreaseBtnClicked;
  

  @override
  Widget build(BuildContext context) {
    return Container( 
      width: MediaQuery.of(context).size.width,
      
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color:Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(color:Colors.black.withOpacity(0.05),blurRadius: 10 ),
        ]
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: ImageLoadingService(
                    imageUrl: data.productEntity.imageUrl,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                  data.productEntity.title,
                  style: TextStyle(fontSize: 16),
                ),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            
            child: Row(
              
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'تعداد',
                      style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .caption!
                              .color),
                    ),
                    SizedBox(height: 2,),
                    SizedBox(
                      height: 35,
                      width: 100,
                      child: Container(
                        
                        
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.5),
                              width: 0.06),
                          color: Theme.of(context).colorScheme.background,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow:[
                            BoxShadow(color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),blurRadius: 10)
                          ],
                        ),
                        child: Flex(direction: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(flex: 1,child: IconButton(style: ButtonStyle(),onPressed: onIncreaseBtnClicked, icon: Icon(CupertinoIcons.plus,size: 20,))),
                          SizedBox(width: 6,),
                          Flexible(flex: 1,child:data.chengeCountLoadig?CupertinoActivityIndicator(color: Theme.of(context).colorScheme.onBackground,): Text(data.count.toString(),style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),)),
                          SizedBox(width: 6,),
                          Flexible(flex: 1,child: IconButton(style: ButtonStyle(),onPressed: onDecreaseBtnClicked, icon: Icon(CupertinoIcons.minus,size: 20,))),
                          
                          
                          
                        ],),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [
                    Text(data.productEntity.previousPrice.withPriceLable,style: TextStyle(decoration:TextDecoration.lineThrough,color: Theme.of(context).textTheme.caption!.color ),),
                    Text(data.productEntity.price.withPriceLable)
                  ],
                )
              ],
            ),
          ),
          Divider(height: 1,),
          data.deleteBtnLoading
              ? SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(child: CupertinoActivityIndicator()))
              : TextButton(
                  onPressed: () {
                    onDeleteBtnClicked();
                  },
                  child: Text('حذف از سبد خرید')),
          
        ],
      ),
    );
  }
}
