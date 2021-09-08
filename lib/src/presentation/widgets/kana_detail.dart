import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';
import 'package:kana_plus_plus/src/presentation/widgets/border_painter.dart';

class KanaDetail extends StatelessWidget {
  const KanaDetail({Key? key, required this.imageUrl, required this.size}) : super(key: key);

  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: size,
      child: Stack(
        children: [
          CustomPaint(painter: BorderPainter(borderWidth: 2.0, borderColor: defaultBorderColor), size: Size(size, size)),
          SvgPicture.asset(imageUrl, width: size, height: size)
        ],
      ),
    );
  }
}
