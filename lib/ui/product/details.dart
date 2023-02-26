import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikestore/common/utils.dart';
import 'package:nikestore/data/product.dart';
import 'package:nikestore/data/repo/cart_repository.dart';
import 'package:nikestore/theme.dart';

import 'package:nikestore/ui/product/bloc/product_bloc.dart';
import 'package:nikestore/ui/product/comment/comment_list.dart';
import 'package:nikestore/ui/widgets/image.dart';

class ProductSetailScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductSetailScreen({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductSetailScreen> createState() => _ProductSetailScreenState();
}

class _ProductSetailScreenState extends State<ProductSetailScreen> {
  StreamSubscription<ProductState>? streamSubscription = null;
  final GlobalKey<ScaffoldMessengerState> _scaffolKey = GlobalKey();
  @override
  void dispose() {
    streamSubscription?.cancel();
    _scaffolKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<ProductBloc>(
        create: (context) {
          final bloc = ProductBloc(cartRepository);
          streamSubscription = bloc.stream.listen((state) {
            if (state is ProductAddToCartError) {
              _scaffolKey.currentState?.showSnackBar(
                  SnackBar(content: Text(state.exception.message)));
            } else if (state is ProductAddToCartSuccess) {
              _scaffolKey.currentState?.showSnackBar(SnackBar(
                  content: Text('با موفقیت به سبد خرید شما اضافه شد')));
            }
          });
          return bloc;
        },
        child: ScaffoldMessenger(
          key: _scaffolKey,
          child: Scaffold(
            floatingActionButton: SizedBox(
              width: MediaQuery.of(context).size.width - 48,
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  return FloatingActionButton.extended(
                      onPressed: () {
                        BlocProvider.of<ProductBloc>(context)
                            .add(CartAddBtnClicked(widget.product.id));
                      },
                      label: state is ProductAddToCartBtnLoading
                          ? CupertinoActivityIndicator(
                              color: Theme.of(context).colorScheme.onSecondary,
                            )
                          : Text('افزودن به سبد خرید'));
                },
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            body: CustomScrollView(
              physics: difaultScrollPhy,
              slivers: [
                SliverAppBar(
                  expandedHeight: MediaQuery.of(context).size.width * 0.8,
                  foregroundColor: LighThemeColors.primaryTextColor,
                  flexibleSpace: ImageLoadingService(
                    imageUrl: widget.product.imageUrl,
                  ),
                  actions: [
                    IconButton(
                        onPressed: () {}, icon: Icon(CupertinoIcons.heart))
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Text(
                              widget.product.title,
                              maxLines: 2,
                              style: Theme.of(context).textTheme.headline6,
                            )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  widget.product.previousPrice.withPriceLable,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                                Text(widget.product.price.withPriceLable),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "  این کتونی برای راه رفتن و دویدن مناسب است و تقریبا هیچ فشار مخری به پا و زانوان شما وارد نمی کند  ",
                          style: TextStyle(height: 1.4),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'نظرات کاربران',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                            TextButton(
                                onPressed: () {}, child: Text('ثبت نظر')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                CommentsList(productId: widget.product.id),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
