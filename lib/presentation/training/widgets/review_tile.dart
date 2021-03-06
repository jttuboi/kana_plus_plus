import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/presentation/training/training.dart';

class ReviewTile extends StatelessWidget {
  const ReviewTile({required this.wordResult, Key? key}) : super(key: key);

  final WordViewModel wordResult;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(wordResult.imageUrl, width: 40),
      title: Text(wordResult.id, style: const TextStyle(fontWeight: FontWeight.bold)),
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
