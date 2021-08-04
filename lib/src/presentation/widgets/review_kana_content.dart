import 'package:flutter/widgets.dart';
import 'package:kana_plus_plus/src/presentation/arguments/kana_result.dart';

class ReviewKanaContent extends StatelessWidget {
  const ReviewKanaContent({
    Key? key,
    required this.kanaResult,
    required this.squareImageUrl,
    required this.correctImageUrl,
    required this.wrongImageUrl,
  }) : super(key: key);

  final KanaResult kanaResult;
  final String squareImageUrl;
  final String correctImageUrl;
  final String wrongImageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32.0,
      child: Stack(
        children: [
          Image.asset(squareImageUrl),
          Image.asset(kanaResult.imageUrl),
          kanaResult.userImage,
          if (kanaResult.isCorrect)
            Image.asset(correctImageUrl)
          else
            Image.asset(wrongImageUrl),
        ],
      ),
    );
  }
}
