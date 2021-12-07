import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/words/words.dart';

void main() {
  group('Filter', () {
    test('returns comparison', () {
      const filterAll = Filter.all;
      expect(filterAll.isAll, isTrue);
      expect(filterAll.isSearched, isFalse);

      const filterSearched = Filter.searched;
      expect(filterSearched.isAll, isFalse);
      expect(filterSearched.isSearched, isTrue);
    });
  });
}
