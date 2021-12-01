import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class ShimmerKanaViewer extends StatelessWidget {
  const ShimmerKanaViewer({required this.height, Key? key}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        initialPage: 2,
        height: height,
        viewportFraction: Device.get().isTablet ? 0.2 : 0.255,
        aspectRatio: 1,
        enableInfiniteScroll: false,
      ),
      itemCount: 5,
      itemBuilder: (context, index, realIndex) {
        return Container(
          width: height,
          height: height,
          color: Colors.black,
        );
      },
    );
  }
}
