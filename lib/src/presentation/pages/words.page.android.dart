import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/data/datasources/banner_url.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/entities/word.dart';
import 'package:kana_plus_plus/src/domain/controllers/words.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/words.arguments.dart';
import 'package:kana_plus_plus/src/presentation/state_management/words.state_management.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';
import 'package:kana_plus_plus/src/presentation/widgets/sliver_flexible_app_bar.dart';
import 'package:kana_plus_plus/src/presentation/widgets/word_item.dart';
import 'package:kana_plus_plus/src/presentation/widgets/words_search_delegate.dart';

class WordsPage extends StatefulWidget {
  const WordsPage(this.controller, {Key? key}) : super(key: key);

  final WordsController controller;

  @override
  _WordsPageState createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  late WordsStateManagement _stateManagement;

  @override
  void initState() {
    super.initState();
    _stateManagement = WordsStateManagement(widget.controller);
  }

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
                onPressed: () => _onPressedSearchButton(context),
                icon: SvgPicture.asset(IconUrl.search, color: Theme.of(context).primaryIconTheme.color),
              ),
            ],
          ),
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<Word>>(
                future: _stateManagement.wordsLoading,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return _buildLoader();
                  }
                  if (snapshot.hasError) {
                    return _buildError(context);
                  }
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final words = snapshot.data!;
                    _updateWordsLoaded(words);
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
                          word: word.id,
                          imageUrl: word.imageUrl,
                          onTap: () => _onTapWordItem(context, word.id),
                        );
                      },
                    );
                  }
                  return _buildNoData(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onPressedSearchButton(BuildContext context) async {
    final strings = JStrings.of(context)!;
    final queryResult = await showSearch(
      context: context,
      delegate: WordsSearchDelegate(
        _stateManagement.wordsLoaded,
        strings.searchLabelInWords,
      ),
    );
    setState(() {
      _stateManagement.fetchWords(queryResult);
    });
  }

  void _onTapWordItem(BuildContext context, String id) {
    _stateManagement.findWord(id).then((value) {
      Navigator.pushNamed(context, Routes.word, arguments: WordsArguments(word: value));
    });
  }

  // look at state management to understand where is used for
  void _updateWordsLoaded(List<Word> words) {
    // only fill at the first time
    if (_stateManagement.wordsLoaded.isEmpty) {
      _stateManagement.wordsLoaded = words;
    }
  }

  Widget _buildLoader() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        IconUrl.error,
        color: Theme.of(context).primaryIconTheme.color,
        width: Theme.of(context).primaryIconTheme.size,
        height: Theme.of(context).primaryIconTheme.size,
      ),
    );
  }

  Widget _buildNoData(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        IconUrl.error,
        color: Theme.of(context).primaryIconTheme.color,
        width: Theme.of(context).primaryIconTheme.size,
        height: Theme.of(context).primaryIconTheme.size,
      ),
    );
  }
}
