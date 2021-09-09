import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FallingKanaAnimation extends StatefulWidget {
  FallingKanaAnimation({
    Key? key,
    required this.initialPosition,
    required this.endYPosition,
    required this.kanaSize,
    required this.durationInMilliseconds,
    this.kanaColor = Colors.black,
  })  : assert(durationInMilliseconds >= 2000),
        super(key: key);

  final Offset initialPosition;
  final double endYPosition;
  final double kanaSize;
  final Color kanaColor;
  final int durationInMilliseconds;

  final List<String> kanasImageUrl = [
    'lib/assets/images/menu/kanas/あ.svg',
    'lib/assets/images/menu/kanas/ア.svg',
    'lib/assets/images/menu/kanas/い.svg',
    'lib/assets/images/menu/kanas/イ.svg',
    'lib/assets/images/menu/kanas/う.svg',
    'lib/assets/images/menu/kanas/ウ.svg',
    'lib/assets/images/menu/kanas/え.svg',
    'lib/assets/images/menu/kanas/エ.svg',
    'lib/assets/images/menu/kanas/お.svg',
    'lib/assets/images/menu/kanas/オ.svg',
  ];

  @override
  _FallingKanaAnimationState createState() => _FallingKanaAnimationState();
}

class _FallingKanaAnimationState extends State<FallingKanaAnimation> with TickerProviderStateMixin {
  late Animation<double> fallingAnimation;
  late Animation<double> opacityAnimation;
  late AnimationController controller;
  late Random random;

  int kanaIndex = 0;
  bool repeated = false;

  @override
  void initState() {
    super.initState();
    random = Random();
    kanaIndex = random.nextInt(widget.kanasImageUrl.length);
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: widget.durationInMilliseconds));
    fallingAnimation = Tween<double>(begin: widget.initialPosition.dy, end: widget.endYPosition).animate(controller)
      ..addListener(() {
        setState(() {
          // it doesn´t have any check when repeats, so this controls looks the value [0..1] to execute once at the moment it's near of
          // repeat time. it has a chance the value is not greater than 0.99, so, it will keep the values you wanna change it.
          // if the duration is small (less than 2 seconds), the problem can increase, so it's good to avoid duration less than 2 seconds.
          if (controller.value < 0.1) {
            repeated = false;
          }

          if (!repeated && controller.value >= 0.99) {
            kanaIndex = random.nextInt(widget.kanasImageUrl.length);
            repeated = true;
          }
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    opacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInExpo,
    ));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Positioned(
          top: fallingAnimation.value,
          left: widget.initialPosition.dx,
          child: Opacity(
            opacity: opacityAnimation.value,
            child: SvgPicture.asset(
              widget.kanasImageUrl[kanaIndex],
              width: widget.kanaSize,
              height: widget.kanaSize,
              color: widget.kanaColor,
            ),
          ),
        );
      },
    );
  }
}
