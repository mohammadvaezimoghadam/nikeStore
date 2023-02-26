import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget{
  final String message;
  final Widget? callToAction;
  final Widget image;

  const EmptyView(
      {Key? key,
      required this.message,
       this.callToAction,
      required this.image})
      : super(key: key);
@override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          image,
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 32, 24, 16),
            child: Text(message,style: Theme.of(context).textTheme.headline6!.copyWith(height: 1.3),textAlign: TextAlign.center,),
          ),
          if(callToAction!=null)callToAction!,
        ],
      ),
    ) ;
  }
      
}