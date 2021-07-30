import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/domain/entities/word.entity.dart';
import 'package:kana_plus_plus/src/domain/exception/not_found.exception.dart';
import 'package:kana_plus_plus/src/presentation/arguments/words.arguments.dart';
import 'package:kana_plus_plus/src/presentation/state_management/words.state_management.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';
import 'package:kana_plus_plus/src/presentation/widgets/words_grid.dart';
import 'package:kana_plus_plus/src/presentation/widgets/words_search_delegate.dart';

class WordsPage extends StatefulWidget {
  const WordsPage(this.stateManagement, {Key? key}) : super(key: key);

  final WordsStateManagement stateManagement;

  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _onPressedSearchButton(context),
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Word>>(
          future: widget.stateManagement.wordsLoading,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return _buildLoader();
            }
            if (snapshot.hasError) {
              return (snapshot.error is NotFoundException)
                  ? _buildNoData()
                  : _buildError();
            }
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              final words = snapshot.data!;
              _updateWordsLoaded(words);
              return WordsGrid(
                words: words,
                onTap: (id) => _onTapWordItem(context, id),
              );
            }
            return _buildNoData();
          },
        ),
      ),
    );
  }

  Future<void> _onPressedSearchButton(BuildContext context) async {
    final JStrings strings = JStrings.of(context)!;
    final queryResult = await showSearch(
      context: context,
      delegate: WordsSearchDelegate(
        widget.stateManagement.wordsLoaded,
        strings.searchLabelInWords,
      ),
    );
    setState(() {
      widget.stateManagement.fetchWords(queryResult);
    });
  }

  void _onTapWordItem(BuildContext context, int id) {
    widget.stateManagement.findWord(id).then((value) {
      Navigator.pushNamed(
        context,
        Routes.word,
        arguments: WordsArguments(word: value),
      );
    });
  }

  // look at state management to understand where is used for
  void _updateWordsLoaded(List<Word> words) {
    // only fill at the first time
    if (widget.stateManagement.wordsLoaded.isEmpty) {
      widget.stateManagement.wordsLoaded = words;
    }
  }

  Widget _buildLoader() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError() {
    // TODO icon
    return const Center(child: Icon(Icons.error));
  }

  Widget _buildNoData() {
    // TODO icon
    return const Center(child: Icon(Icons.cloud_off));
  }
}
