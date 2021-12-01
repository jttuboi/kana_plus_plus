import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';

void main() {
  group('IconUrl', () {
    test('returns constants', () {
      expect(IconUrl.iconsFolder, 'assets/icons/');
      expect(IconUrl.app, 'assets/icons/app_icon.png');
      expect(IconUrl.about, 'assets/icons/about.svg');
      expect(IconUrl.back, 'assets/icons/back.svg');
      expect(IconUrl.both, 'assets/icons/both.svg');
      expect(IconUrl.clear, 'assets/icons/clear.svg');
      expect(IconUrl.empty, 'assets/icons/empty.svg');
      expect(IconUrl.eraser, 'assets/icons/eraser.svg');
      expect(IconUrl.error, 'assets/icons/error.svg');
      expect(IconUrl.hiragana, 'assets/icons/hiragana.svg');
      expect(IconUrl.katakana, 'assets/icons/katakana.svg');
      expect(IconUrl.language, 'assets/icons/language.svg');
      expect(IconUrl.notShowHint, 'assets/icons/not_show_hint.svg');
      expect(IconUrl.play, 'assets/icons/play.svg');
      expect(IconUrl.privacyPolicy, 'assets/icons/privacy_policy.svg');
      expect(IconUrl.quantityOfWords, 'assets/icons/quantity_of_words.svg');
      expect(IconUrl.quitTraining, 'assets/icons/quit.svg');
      expect(IconUrl.rate, 'assets/icons/rate.svg');
      expect(IconUrl.search, 'assets/icons/search.svg');
      expect(IconUrl.settings, 'assets/icons/settings.svg');
      expect(IconUrl.share, 'assets/icons/share.svg');
      expect(IconUrl.showAll, 'assets/icons/show_all.svg');
      expect(IconUrl.showHint, 'assets/icons/show_hint.svg');
      expect(IconUrl.study, 'assets/icons/study.svg');
      expect(IconUrl.support, 'assets/icons/support.svg');
      expect(IconUrl.training, 'assets/icons/training.svg');
      expect(IconUrl.undo, 'assets/icons/undo.svg');
      expect(IconUrl.words, 'assets/icons/words.svg');
    });
  });
}
