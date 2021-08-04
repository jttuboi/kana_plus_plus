import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_result.dart';
import 'package:kana_plus_plus/src/presentation/widgets/review_kana_content.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile(
    this.wordResult, {
    Key? key,
    required this.squareImageUrl,
    required this.correctImageUrl,
    required this.wrongImageUrl,
  }) : super(key: key);

  final WordResult wordResult;
  final String squareImageUrl;
  final String correctImageUrl;
  final String wrongImageUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(wordResult.imageUrl),
      title: Text(wordResult.text),
      subtitle: Container(
        alignment: Alignment.centerLeft,
        constraints: const BoxConstraints.expand(width: 200.0, height: 40.0),
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 4.0),
          itemCount: wordResult.kanas.length,
          itemBuilder: (context, index) {
            return ReviewKanaContent(
              kanaResult: wordResult.kanas[index],
              squareImageUrl: squareImageUrl,
              correctImageUrl: correctImageUrl,
              wrongImageUrl: wrongImageUrl,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 4.0),
        ),
      ),
    );
  }
}
