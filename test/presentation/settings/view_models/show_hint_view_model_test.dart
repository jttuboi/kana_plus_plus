import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/settings/settings.dart';

void main() {
  group('ShowHintViewModel', () {
    test('sets field correctly', () {
      const viewModel = ShowHintViewModel(showHint: false, iconUrl: IconUrl.notShowHint);

      expect(viewModel.showHint, isFalse);
      expect(viewModel.iconUrl, IconUrl.notShowHint);
    });

    test('is empty', () {
      const viewModel = ShowHintViewModel.empty;

      expect(viewModel.showHint, isTrue);
      expect(viewModel.iconUrl, IconUrl.empty);
    });
  });
}
