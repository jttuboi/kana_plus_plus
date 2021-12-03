import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/shared/shared.dart';

void main() {
  group('SelectionOptionItem', () {
    test('creates objects properly', () {
      const item = SelectionOptionItem(key: 'key', label: 'label', iconUrl: 'iconUrl');

      expect(item.key, 'key');
      expect(item.label, 'label');
      expect(item.iconUrl, 'iconUrl');
    });
  });
}
