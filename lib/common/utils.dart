import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

const difaultScrollPhy=BouncingScrollPhysics();

extension PriceLable on int{
  String get withPriceLable =>this>0? '$seprateByComma تومان':'رایگان';

  String get seprateByComma {
    final numberFormat=NumberFormat.decimalPattern();
    return numberFormat.format(this) ;
  }

}