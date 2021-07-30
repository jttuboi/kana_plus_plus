import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/presentation/arguments/words.arguments.dart';
import 'package:kana_plus_plus/src/presentation/state_management/words.state_management.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';
import 'package:kana_plus_plus/src/presentation/widgets/word_item.dart';

class WordsPage extends StatelessWidget {
  const WordsPage(this._stateManagement, {Key? key}) : super(key: key);

  final WordsStateManagement _stateManagement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          _SearchButton(
            onPressed: () async {
              await _stateManagement.list.then((value) => print(value));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Word>>(
          future: _stateManagement.list,
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
                final word = snapshot.data![index];
                return WordItem(
                  word: word.word,
                  imageUrl: word.imageUrl,
                  onTap: () async {
                    await _stateManagement.findWord(word.id).then((value) {
                      Navigator.pushNamed(
                        context,
                        Routes.word,
                        arguments: WordsArguments(word: value),
                      );
                    });
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
    return IconButton(onPressed: onPressed, icon: const Icon(Icons.search));
  }
}
