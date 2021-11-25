import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/words/words.dart';

class WordsSearchDelegate extends SearchDelegate {
  WordsSearchDelegate({
    required this.words,
    required String searchFieldLabel,
  }) : super(
          keyboardType: TextInputType.text,
          searchFieldLabel: searchFieldLabel,
        );

  final List<Word> words;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  void showResults(BuildContext context) {
    close(context, query.trim());
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: SvgPicture.asset(IconUrl.clear, color: Theme.of(context).primaryIconTheme.color),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(IconUrl.back, color: Theme.of(context).primaryIconTheme.color),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions =
        (query.trim().isEmpty) ? words.getRange(0, 4).map((word) => word).toList() : words.where(_hasQuery).map((word) => word).toList();
    return _buildSuggestions(suggestions);
  }

  bool _hasQuery(Word word) {
    return word.id.contains(query.trim()) || word.romaji.contains(query.trim()) || word.translate.contains(query.trim());
  }

  Widget _buildSuggestions(List<Word> suggestions) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final word = suggestions[index];
        return ListTile(
          title: Text('${word.id} - ${word.romaji}'),
          subtitle: Text(word.translate),
          onTap: () => close(context, word.id),
        );
      },
    );
  }
}
