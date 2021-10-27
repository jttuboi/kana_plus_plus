import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/menu/presentation/widgets/flexible_scaffold.dart';
import 'package:kwriting/src/infrastructure/datasources/banner_url.storage.dart';
import 'package:kwriting/src/infrastructure/datasources/icon_url.storage.dart';
import 'package:kwriting/src/presentation/utils/routes.dart';
import 'package:kwriting/training/presentation/arguments/words.arguments.dart';
import 'package:kwriting/words/domain/use_cases/words.controller.dart';
import 'package:kwriting/words/presentation/notifiers/words.change_notifier.dart';
import 'package:kwriting/words/presentation/widgets/word_item.dart';
import 'package:kwriting/words/presentation/widgets/words_search_delegate.dart';
import 'package:provider/provider.dart';

class WordsPage extends StatelessWidget {
  const WordsPage(this.wordsController, {Key? key}) : super(key: key);

  final WordsController wordsController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WordsProvider(wordsController)),
      ],
      builder: (context, child) => _WordsPage(wordsController: wordsController),
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
      sliverContent: Consumer<WordsProvider>(
        builder: (context, provider, child) {
          return SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final word = provider.wordsToShow[index];
                  return WordItem(
                    word: word.id,
                    imageUrl: word.imageUrl,
                    onTap: () => _onTapWordItem(context, word.id),
                  );
                },
                childCount: provider.wordsToShow.length,
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
      Provider.of<WordsProvider>(context, listen: false).fetchWords(queryResult);
    });
  }

  void _onTapWordItem(BuildContext context, String id) {
    Navigator.pushNamed(context, Routes.word, arguments: WordsArguments(word: wordsController.wordDetail(id)));
  }
}
