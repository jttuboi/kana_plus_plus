import 'package:flutter/material.dart';

// https://docs.flutter.dev/cookbook/effects/shimmer-loading
class Shimmer extends StatefulWidget {
  const Shimmer({this.child, Key? key}) : super(key: key);

  final Widget? child;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with TickerProviderStateMixin {
  late AnimationController _shimmerController;
  GlobalKey key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController.unbounded(vsync: this)..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _shimmerController
      ..removeListener(_onShimmerChange)
      ..addListener(_onShimmerChange);
  }

  @override
  void dispose() {
    _shimmerController
      ..removeListener(_onShimmerChange)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ShaderMask(
        key: key,
        blendMode: BlendMode.srcATop,
        shaderCallback: (bounds) {
          final box = key.currentContext!.findRenderObject()! as RenderBox;
          final position = box.localToGlobal(Offset.zero);
          return gradient.createShader(Rect.fromLTWH(-position.dx, -position.dy, constraints.maxWidth, constraints.maxHeight));
        },
        child: widget.child,
      );
    });
  }

  LinearGradient get gradient {
    return LinearGradient(
      colors: _shimmerGradient.colors,
      stops: _shimmerGradient.stops,
      begin: _shimmerGradient.begin,
      end: _shimmerGradient.end,
      transform: _SlidingGradientTransform(slidePercent: _shimmerController.value),
    );
  }

  void _onShimmerChange() {
    // update the shimmer painting.
    setState(() {});
  }
}

const _shimmerGradient = LinearGradient(
  colors: [
    Color(0xFFEBEBF4),
    Color(0xFFF4F4F4),
    Color(0xFFEBEBF4),
  ],
  stops: [
    0.1,
    0.3,
    0.4,
  ],
  begin: Alignment(-1, -0.3),
  end: Alignment(1, 0.3),
  // ignore: avoid_redundant_argument_values
  tileMode: TileMode.clamp,
);

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({required this.slidePercent});

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0, 0);
  }
}
