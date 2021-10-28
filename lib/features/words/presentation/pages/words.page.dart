import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/words/words.dart';
import 'package:provider/provider.dart';

class WordsPage extends StatelessWidget {
  const WordsPage._(this._wordsController, {Key? key}) : super(key: key);

  static const routeName = '/words';
  static const argWordsController = 'argWordsController';

  static Route route(WordsController wordsController) {
    return MaterialPageRoute(builder: (context) => WordsPage._(wordsController));
  }

  final WordsController _wordsController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WordsChangeNotifier(_wordsController)),
      ],
      builder: (context, child) => _WordsPage(wordsController: _wordsController),
    );
  }
}

class _WordsPage extends StatelessWidget {
  const _WordsPage({required this.wordsController, Key? key}) : super(key: key);

  final WordsController wordsController;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return FlexibleScaffold(
      title: strings.wordsTitle,
      bannerUrl: BannerUrl.words,
      onBackButtonPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
      actions: [
        IconButton(
          icon: SvgPicture.asset(IconUrl.search, color: Theme.of(context).primaryIconTheme.color),
          onPressed: () => _onPressedSearchButton(context),
        ),
      ],
      sliverContent: Consumer<WordsChangeNotifier>(
        builder: (context, changeNotifier, child) {
          return SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final word = changeNotifier.wordsToShow[index];
                  return WordItem(
                    word: word.id,
                    imageUrl: word.imageUrl,
                    onTap: () => _onTapWordItem(context, word.id),
                  );
                },
                childCount: changeNotifier.wordsToShow.length,
              ),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 9 / 10,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
              ),
            ),
          );
        },
      ),
    );
  }

  void _onPressedSearchButton(BuildContext context) {
    final strings = JStrings.of(context)!;
    showSearch(
      context: context,
      delegate: WordsSearchDelegate(
        words: wordsController.allWords,
        searchFieldLabel: strings.searchLabelInWords,
      ),
    ).then((queryResult) {
      Provider.of<WordsChangeNotifier>(context, listen: false).fetchWords(queryResult);
    });
  }

  void _onTapWordItem(BuildContext context, String id) {
    Navigator.pushNamed(
      context,
      WordDetailPage.routeName,
      arguments: {
        WordDetailPage.argWord: wordsController.wordDetail(id),
      },
    );
  }
}
