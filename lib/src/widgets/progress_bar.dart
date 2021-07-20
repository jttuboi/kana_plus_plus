import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar(
    this.currentWord, {
    Key? key,
    required this.maxWords,
  }) : super(key: key);

  final int currentWord;
  final int maxWords;

  @override
  _ProgressBarState createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Tween<double> _valueTween;
  late Animation<double> _curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _controller.forward();

    _valueTween = Tween(begin: 0.0, end: 0.0);

    _curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void didUpdateWidget(covariant ProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.currentWord != oldWidget.currentWord) {
      _valueTween = Tween(
        begin: _valueTween.evaluate(_controller),
        end: widget.currentWord / widget.maxWords,
      );

      _controller
        ..value = 0
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curve,
      builder: (context, child) {
        return LinearProgressIndicator(
          value: _valueTween.evaluate(_curve),
          backgroundColor: Colors.green,
          color: Colors.red,
          minHeight: 6,
        );
      },
    );
  }
}
