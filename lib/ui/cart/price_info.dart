import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikestore/common/utils.dart';
import 'package:nikestore/theme.dart';

class PriceInfo extends StatelessWidget{
  final int payablePrice;
  final int shippingPrice;
  final int totalOrice;

  const PriceInfo({Key? key, required this.payablePrice, required this.shippingPrice, required this.totalOrice}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0,24,8,0),
          child: Text('خلاصه سبد',style: Theme.of(context).textTheme.subtitle1,),
        ),
        Container( 
          margin: EdgeInsets.fromLTRB(8, 8, 8, 32),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
                BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05))
            ]

          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8,12,8,12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(' مبلغ کل خرید'),
                    RichText(
                      text: TextSpan(
                          text: totalOrice.seprateByComma,
                          style: DefaultTextStyle.of(context)
                              .style
                              .apply(color: LighThemeColors.secondaryColor),
                          children: const [
                            TextSpan(
                                text: 'تومان',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: LighThemeColors.primaryColor))
                              ]),
                               
                    )

                  ],
                ),
              ),
              const Divider(height: 1,),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,12,8,12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(' هزینه ارسال  '),
                    Text(shippingPrice.withPriceLable),

                  ],
                ),
              ),
              
              const Divider(height: 1,),
              Padding(
                padding: const EdgeInsets.fromLTRB(8,12,8,12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(' مبلغ قابل پرداخت '),
                    RichText(text: TextSpan(
                            text: payablePrice.seprateByComma,
                            style: DefaultTextStyle.of(context)
                                .style
                                .copyWith(fontWeight: FontWeight.bold),
                                children:const [
                            TextSpan(
                                text: ' تومان',
                                style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal,
                                    color: LighThemeColors.primaryColor))
                                ]
                    ),)

                  ],
                ),
              ),


            ],
          ),
        ),
      ],
    ) ;
  }
  
  
}