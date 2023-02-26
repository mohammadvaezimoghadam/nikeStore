import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nikestore/common/utils.dart';
import 'package:nikestore/data/product.dart';

import 'package:nikestore/ui/product/details.dart';
import 'package:nikestore/ui/widgets/image.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
    required this.product, required this.borderRadius,
  }) : super(key: key);

  final ProductEntity product;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(4.0),
        child: InkWell(
          borderRadius: borderRadius,
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProductSetailScreen(product: product,)));
          },
          child: SizedBox(
            width: 176,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 176,
                      height: 189,
                      child: ImageLoadingService(
                          imageUrl: product.imageUrl,
                          borderRadius: borderRadius),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Icon(
                          CupertinoIcons.heart,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: Text(
                    product.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  child: Text(
                    product.previousPrice.withPriceLable,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(decoration: TextDecoration.lineThrough),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8, left: 8, top: 4),
                  child: Text(product.price.withPriceLable),
                ),
              ],
            ),
          ),
        ));
  }
}
