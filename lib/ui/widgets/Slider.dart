import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nikestore/common/utils.dart';
import 'package:nikestore/ui/widgets/image.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../data/banner.dart';

class BannerSlider extends StatefulWidget {
  final List<BannerEntity> banners;
  const BannerSlider({
    Key? key,
    required this.banners,
  }) : super(key: key);

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  final PageController _controller = PageController(
    initialPage: 0,
  );
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _controller.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          PageView.builder(
              controller: _controller,
              itemCount: widget.banners.length,
              physics: difaultScrollPhy,
              itemBuilder: ((context, index) {
                return _Slide(banner: widget.banners[index]);
              })),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: widget.banners.length,
                axisDirection: Axis.horizontal,
                effect: WormEffect(
                    spacing: 4.0,
                    radius: 4.0,
                    dotWidth: 20.0,
                    dotHeight: 3.0,
                    paintStyle: PaintingStyle.fill,
                    dotColor: Colors.grey.shade400,
                    activeDotColor: Theme.of(context).colorScheme.onBackground),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  const _Slide({
    Key? key,
    required this.banner,
  }) : super(key: key);
  final BannerEntity banner;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12),
      child: ImageLoadingService(
          borderRadius: BorderRadius.circular(12), imageUrl: banner.imageUrl),
    );
  }
}
class Badge extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container() ;
  }
}

