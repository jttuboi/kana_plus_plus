import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/settings/settings.dart';

void main() {
  group('KanaTypeViewModel', () {
    test('sets field correctly', () {
      const viewModel = KanaTypeViewModel(kanaType: KanaType.katakana, iconUrl: IconUrl.katakana);

      expect(viewModel.kanaType, KanaType.katakana);
      expect(viewModel.iconUrl, IconUrl.katakana);
    });

    test('is empty', () {
      const viewModel = KanaTypeViewModel.empty;

      expect(viewModel.kanaType, KanaType.both);
      expect(viewModel.iconUrl, IconUrl.empty);
    });
  });
}
