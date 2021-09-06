import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_result.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';
import 'package:kana_plus_plus/src/presentation/widgets/review_kana_content.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({
    Key? key,
    required this.wordResult,
  }) : super(key: key);

  final WordResult wordResult;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(wordResult.imageUrl, width: 56.0),
      title: Text(wordResult.id, style: reviewTileTitleStyle),
      subtitle: Container(
        alignment: Alignment.centerLeft,
        constraints: const BoxConstraints.expand(width: 200.0, height: 40.0),
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 4.0),
          itemCount: wordResult.kanas.length,
          itemBuilder: (context, index) {
            return ReviewKanaContent(kanaResult: wordResult.kanas[index]);
          },
          separatorBuilder: (context, index) => const SizedBox(width: 4.0),
        ),
      ),
    );
  }
}
