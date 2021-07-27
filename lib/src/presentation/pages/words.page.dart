import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/data/models/word.model.dart';
import 'package:kana_plus_plus/src/data/repositories/data_test_words.repository.dart';
import 'package:kana_plus_plus/src/domain/repositories/words.interface.dart';
import 'package:kana_plus_plus/src/presentation/routes.dart';
import 'package:kana_plus_plus/src/shared/images.dart';

class WordsBloc {
  WordsBloc(this._repository);

  final IWordsRepository _repository;

  List<WordModel> get list => _repository.getWords();
}

class WordsPage extends StatelessWidget {
  WordsPage({Key? key}) : super(key: key);

  final _bloc = WordsBloc(DataTestWordsRepository());

  @override
  Widget build(BuildContext context) {
    final JStrings strings = JStrings.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Words"), //strings.wordsTitle
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 9 / 10,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
          itemCount: _bloc.list.length,
          itemBuilder: (context, index) {
            return ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey[100]),
                //shadowColor: MaterialStateProperty.all(Colors.transparent),
              ),
              onPressed: () {},
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.topCenter,
                      child: Image.asset(_bloc.list[index].imageUrl)),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      _bloc.list[index].word,
                      style: TextStyle(
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
          // ElevatedButton(
          //   onPressed: () => Navigator.pushNamed(context, Routes.word),
          //   child: const Text("rain"),
          // ),
        ),
      ),
    );
  }
}
