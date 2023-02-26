import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nikestore/common/exception.dart';
import 'package:nikestore/common/utils.dart';
import 'package:nikestore/data/banner.dart';
import 'package:nikestore/data/product.dart';
import 'package:nikestore/data/repo/banner_repository.dart';
import 'package:nikestore/data/repo/product_repo.dart';
import 'package:nikestore/ui/home/bloc/home_bloc.dart';

import 'package:nikestore/ui/product/product.dart';
import 'package:nikestore/ui/widgets/Slider.dart';
import 'package:nikestore/ui/widgets/error.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final homeBloc = HomeBloc(
            bannerRepository: bannerRepository,
            productRepsitory: productRepository);
        homeBloc.add(HomeStarted());
        return homeBloc;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSuccess) {
                return ListView.builder(
                    physics: difaultScrollPhy,
                    itemCount: 5,
                    itemBuilder: ((context, index) {
                      switch (index) {
                        case 0:
                          return Container(
                            height: 56,
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/img/nike_logo.png',
                              height: 24,
                              fit: BoxFit.fitHeight,
                            ),
                          );
                        case 2:
                          return BannerSlider(
                            banners: state.banners,
                          );
                        case 3:
                          return _HorizontalProductList(
                            title: "جدید ترین",
                            products: state.latestProducts,
                            onTap: () {},
                          );
                        case 4:
                          return _HorizontalProductList(
                              title: "پر بازدید ترین",
                              products: state.popularProducts,
                              onTap: () {});

                        default:
                          return Container();
                      }
                    }));
              } else if (state is HomeLoading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state is HomeError) {
                return AppErrorWidget(
                  exception: state.exception,
                  onPressed: () {
                    BlocProvider.of<HomeBloc>(context).add(HomeRefresh());
                  },
                );
              } else {
                throw Exception();
              }
            },
          ),
        ),
      ),
    );
  }
}



class _HorizontalProductList extends StatelessWidget {
  final String title;
  final List<ProductEntity> products;
  final GestureTapCallback onTap;
  const _HorizontalProductList({
    Key? key,
    required this.title,
    required this.products,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              TextButton(onPressed: () {}, child: Text("مشاهده همه"))
            ],
          ),
        ),
        SizedBox(
          height: 290,
          child: ListView.builder(
              itemCount: products.length,
              physics: difaultScrollPhy,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 8, right: 8),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductItem(
                  product: product,
                  borderRadius: BorderRadius.circular(12),
                );
              }),
        ),
      ],
    );
  }
}
