import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';

class KanaViewers extends StatefulWidget {
  const KanaViewers({
    required this.width,
    required this.height,
    Key? key,
  }) : super(key: key);

  final double width;
  final double height;

  @override
  State<KanaViewers> createState() => _KanaViewersState();
}

class _KanaViewersState extends State<KanaViewers> {
  final _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: BlocConsumer<KanaBloc, KanaState>(
        listener: (context, state) {
          if (state is KanaReady) {
            if (_carouselController.ready && state.index != 0) {
              _carouselController.animateToPage(state.index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOutCubic);
            }
          }
        },
        builder: (context, kanaState) {
          if (kanaState is KanaReady) {
            return CarouselSlider.builder(
              options: CarouselOptions(
                height: widget.height,
                viewportFraction: Device.get().isTablet ? 0.2 : 0.255,
                aspectRatio: 1,
                enableInfiniteScroll: false,
              ),
              carouselController: _carouselController,
              itemCount: kanaState.total,
              itemBuilder: (context, index, realIndex) {
                return KanaViewer(kanaState.kanas[index], squareSize: widget.height);
              },
            );
          }
          return Shimmer(child: ShimmerKanaViewer(height: widget.height));
        },
      ),
    );
  }
}
