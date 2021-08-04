import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/presentation/widgets/word_item.dart';

class WordsGrid extends StatelessWidget {
  const WordsGrid({
    Key? key,
    required this.words,
    required this.onTap,
  }) : super(key: key);

  final List<Word> words;
  final Function(int id) onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 9 / 10,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemCount: words.length,
      itemBuilder: (context1, index) {
        final word = words[index];
        return WordItem(
          word: word.text,
          imageUrl: word.imageUrl,
          onTap: () => onTap(word.id),
        );
      },
    );
  }
}
