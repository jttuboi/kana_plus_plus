import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';

void main() {
  group('BannerUrl', () {
    test('returns constants', () {
      expect(BannerUrl.bannersFolder, 'assets/images/banners/');
      expect(BannerUrl.kanaType, 'assets/images/banners/kana_type.svg');
      expect(BannerUrl.language, 'assets/images/banners/language.svg');
      expect(BannerUrl.preTraining, 'assets/images/banners/pre_training.svg');
      expect(BannerUrl.review, 'assets/images/banners/review.svg');
      expect(BannerUrl.settings, 'assets/images/banners/settings.svg');
      expect(BannerUrl.study, 'assets/images/banners/study.svg');
      expect(BannerUrl.words, 'assets/images/banners/words.svg');
    });
  });
}
