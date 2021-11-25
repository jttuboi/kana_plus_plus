import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:kwriting/presentation/words/words.dart';

class WordsPage extends StatelessWidget {
  const WordsPage._({Key? key}) : super(key: key);

  static const routeName = '/words';
  static const argWordsController = 'argWordsController';

  static Route route() {
    return MaterialPageRoute(builder: (context) => const WordsPage._());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WordsBloc(wordsRepository: WordsRepository())..add(const WordsLoaded())),
        BlocProvider(create: (context) => FilteredWordsBloc(wordsBloc: BlocProvider.of<WordsBloc>(context))),
      ],
      child: const WordsView(),
    );
  }
}

class WordsView extends StatelessWidget {
  const WordsView({Key? key}) : super(key: key);

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
      sliverContent: SliverPadding(
        padding: const EdgeInsets.all(8),
        sliver: BlocBuilder<FilteredWordsBloc, FilteredWordsState>(
          builder: (context, state) {
            if (state is FilteredWordsLoadSuccess) {
              return SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final word = state.filteredWords[index];
                    return WordItem(
                      word: word.id,
                      imageUrl: word.imageUrl,
                      onTap: () => Navigator.pushNamed(
                        context,
                        WordDetailPage.routeName,
                        arguments: {
                          WordDetailPage.argWord: word,
                        },
                      ),
                    );
                  },
                  childCount: state.filteredWords.length,
                ),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 9 / 10,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
              );
            }
            if (state is WordsLoadInProgress) {
              return const SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
            }
            return SliverFillRemaining(child: Center(child: Text(strings.errorBack)));
          },
        ),
      ),
    );
  }

  void _onPressedSearchButton(BuildContext context) {
    final strings = JStrings.of(context)!;
    showSearch(
      context: context,
      delegate: WordsSearchDelegate(
        words: (context.read<WordsBloc>().state is WordsLoadSuccess) ? (context.read<WordsBloc>().state as WordsLoadSuccess).words : [],
        searchFieldLabel: strings.searchLabelInWords,
      ),
    ).then((queryResult) {
      context.read<FilteredWordsBloc>().add(FilterUpdated(Filter.searched, queryResult));
    });
  }
}
