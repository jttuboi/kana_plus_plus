import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';

void main() {
  group('ImageUrl', () {
    test('returns constants', () {
      expect(ImageUrl.imageFolder, 'assets/images/');
      expect(ImageUrl.empty, 'assets/images/empty.svg');
      expect(ImageUrl.introRecommendation, 'assets/images/menu/introduction/recommendation.svg');
      expect(ImageUrl.introStudy, 'assets/images/menu/introduction/study.svg');
      expect(ImageUrl.introTraining, 'assets/images/menu/introduction/training.svg');
      expect(ImageUrl.introVocabulary, 'assets/images/menu/introduction/vocabulary.svg');
      expect(ImageUrl.introWriting, 'assets/images/menu/introduction/writing.svg');

      expect(ImageUrl.menuKanas[0], 'assets/images/menu/kanas/あ.svg');
      expect(ImageUrl.menuKanas[1], 'assets/images/menu/kanas/ア.svg');
      expect(ImageUrl.menuKanas[2], 'assets/images/menu/kanas/い.svg');
      expect(ImageUrl.menuKanas[3], 'assets/images/menu/kanas/イ.svg');
      expect(ImageUrl.menuKanas[4], 'assets/images/menu/kanas/う.svg');
      expect(ImageUrl.menuKanas[5], 'assets/images/menu/kanas/ウ.svg');
      expect(ImageUrl.menuKanas[6], 'assets/images/menu/kanas/え.svg');
      expect(ImageUrl.menuKanas[7], 'assets/images/menu/kanas/エ.svg');
      expect(ImageUrl.menuKanas[8], 'assets/images/menu/kanas/お.svg');
      expect(ImageUrl.menuKanas[9], 'assets/images/menu/kanas/オ.svg');
    });
  });
}
