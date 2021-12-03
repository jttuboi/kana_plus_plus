// ignore_for_file: prefer_function_declarations_over_variables

import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/shared/shared.dart';

void main() {
  group('SelectionOptionArgs', () {
    test('creates objetc properly', () {
      final options = <SelectionOptionItem>[const SelectionOptionItem(key: 'key', label: 'label')];
      final onSelected = (dynamic) {};

      final args = SelectionOptionArgs(
        title: 'title',
        bannerUrl: 'bannerUrl',
        selectedOptionKey: KanaType.hiragana,
        options: options,
        onSelected: onSelected,
      );

      expect(args.title, 'title');
      expect(args.bannerUrl, 'bannerUrl');
      expect(args.selectedOptionKey, KanaType.hiragana);
      expect(args.options, options);
      expect(args.onSelected, onSelected);
    });
  });
}
