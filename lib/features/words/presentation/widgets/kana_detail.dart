import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/features/training/training.dart';

class KanaDetail extends StatelessWidget {
  const KanaDetail({required this.imageUrl, required this.size, Key? key}) : super(key: key);

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size,
      child: Stack(
        children: [
          CustomPaint(painter: BorderPainter(borderWidth: 2, borderColor: Colors.grey.shade500), size: Size(size, size)),
          SvgPicture.asset(imageUrl, width: size, height: size)
        ],
      ),
    );
  }
}
