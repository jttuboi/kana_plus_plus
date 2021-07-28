import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/data/repositories/words.repository.dart';
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/presentation/blocs/words.bloc.dart';
import 'package:kana_plus_plus/src/presentation/routes.dart';

class WordsPage extends StatelessWidget {
  WordsPage({Key? key}) : super(key: key);

  final _bloc = WordsBloc(WordsRepository());

  @override
  Widget build(BuildContext context) {
    final JStrings strings = JStrings.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Words"), //strings.wordsTitle
        actions: [
          IconButton(
              onPressed: () async {
                await _bloc
                    .list(Localizations.localeOf(context).toString())
                    .then((value) {});
              },
              icon: const Icon(Icons.bug_report)),
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
              itemBuilder: (context, index) {
                return ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.grey[100]),
                    //shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.word);
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.topCenter,
                          child: Image.asset(snapshot.data![index].imageUrl)),
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          snapshot.data![index].word,
                          style: const TextStyle(
                            fontSize: 37,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
