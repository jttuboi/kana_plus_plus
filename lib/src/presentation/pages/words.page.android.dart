import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/data/datasources/banner_url.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/controllers/words.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/words.arguments.dart';
import 'package:kana_plus_plus/src/presentation/state_management/words.state_management.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';
import 'package:kana_plus_plus/src/presentation/widgets/sliver_flexible_app_bar.dart';
import 'package:kana_plus_plus/src/presentation/widgets/word_item.dart';
import 'package:kana_plus_plus/src/presentation/widgets/words_search_delegate.dart';
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
  const _WordsPage({Key? key, required this.wordsController}) : super(key: key);

  final WordsController wordsController;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          SliverFlexibleAppBar(
            title: strings.wordsTitle,
            bannerUrl: BannerUrl.words,
            onBackButtonPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            actions: [
              IconButton(
                icon: SvgPicture.asset(IconUrl.search, color: Theme.of(context).primaryIconTheme.color),
                onPressed: () => _onPressedSearchButton(context),
              ),
            ],
          ),
          Consumer<WordsProvider>(
            builder: (context, provider, child) {
              return SliverPadding(
                padding: const EdgeInsets.all(8.0),
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
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                ),
              );
            },
          ),
        ],
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
