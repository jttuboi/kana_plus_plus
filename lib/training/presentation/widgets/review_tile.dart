import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:kwriting/training/presentation/arguments/word_result.dart';
import 'package:kwriting/training/presentation/widgets/review_kana_content.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({required this.wordResult, Key? key}) : super(key: key);

  final WordResult wordResult;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(wordResult.imageUrl, width: 40),
      title: Text(wordResult.id, style: reviewTileTitleStyle),
      subtitle: Container(
        alignment: Alignment.centerLeft,
        constraints: const BoxConstraints.expand(width: 200, height: 40),
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 4),
          itemCount: wordResult.kanas.length,
          itemBuilder: (context, index) {
            return ReviewKanaContent(kanaResult: wordResult.kanas[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(width: 4),
        ),
      ),
    );
  }
}
