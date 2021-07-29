import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/data/repositories/words.repository.dart';
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/presentation/arguments/words.arguments.dart';
import 'package:kana_plus_plus/src/presentation/blocs/words.bloc.dart';
import 'package:kana_plus_plus/src/presentation/routes.dart';

class WordsPage extends StatelessWidget {
  WordsPage({Key? key}) : super(key: key);

  final _bloc = WordsBloc(WordsRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _SearchButton(
            onPressed: () async {
              var locale = Localizations.localeOf(context).toString();
              await _bloc.list(locale).then((value) => print(value));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Word>>(
          future: _bloc.list(Localizations.localeOf(context).toString()),
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
                return _WordItem(
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

class _WordItem extends StatelessWidget {
  const _WordItem({
    Key? key,
    required this.word,
    required this.imageUrl,
    required this.onTap,
  }) : super(key: key);

  final String word;
  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.topCenter,
              child: Hero(
                tag: imageUrl,
                child: Image.asset(imageUrl),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.bottomCenter,
              child: Text(
                word,
                style: const TextStyle(
                  fontSize: 37,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
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
