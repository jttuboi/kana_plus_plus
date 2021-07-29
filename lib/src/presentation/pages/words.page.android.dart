import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/data/repositories/words.repository.dart';
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/presentation/arguments/words.arguments.dart';
import 'package:kana_plus_plus/src/presentation/state_management/words.state_management.dart';
import 'package:kana_plus_plus/src/presentation/routes.dart';
import 'package:kana_plus_plus/src/presentation/widgets/word_item.dart';

class WordsPage extends StatelessWidget {
  WordsPage({Key? key}) : super(key: key);

  final _stateManagement = WordsStateManagement(WordsRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _SearchButton(
            onPressed: () async {
              var locale = Localizations.localeOf(context).toString();
              await _stateManagement.list(locale).then((value) => print(value));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Word>>(
          future:
              _stateManagement.list(Localizations.localeOf(context).toString()),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 9 / 10,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context1, index) {
                var word = snapshot.data![index];
                return WordItem(
                  word: word.word,
                  imageUrl: word.imageUrl,
                  onTap: () {
                    final Word getWord = Word(
                        id: word.id,
                        word: word.word,
                        imageUrl: word.imageUrl,
                        romaji: "teste",
                        translate: word.translate);
                    Navigator.pushNamed(
                      context,
                      Routes.word,
                      arguments: WordsArguments(word: getWord),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _SearchButton extends StatelessWidget {
  const _SearchButton({Key? key, required this.onPressed}) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: Icon(Icons.search));
  }
}
