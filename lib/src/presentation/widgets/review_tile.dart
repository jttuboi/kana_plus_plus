import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_result.dart';

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
      leading: Image.asset("lib/assets/images/words/rain.png"),
      // wordsResult[0].wordId procura pela imagem do rain
      title: const Text("あめ"),
      // wordsResult[0].wordId procura pela palavra do rain
      subtitle: Container(
        alignment: Alignment.centerLeft,
        constraints: const BoxConstraints.expand(width: 200.0, height: 40.0),
        child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(top: 4.0),
          itemCount: wordResult.kanasResult.length,
          itemBuilder: (context, index) {
            return SizedBox(
              width: 32.0,
              child: Stack(
                children: [
                  // tem q vir do background
                  Image.asset(squareImageUrl),
                  Image.asset("lib/assets/images/kanas/h_a.png"),
                  //wordsResult[0].kanasResult[index].kanaId procura pela imagem do hiragana
                  wordResult.kanasResult[index].userKana,
                  if (wordResult.kanasResult[index].correct)
                    Image.asset(correctImageUrl)
                  else
                    Image.asset(wrongImageUrl),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 4.0),
        ),
      ),
    );
  }
}
