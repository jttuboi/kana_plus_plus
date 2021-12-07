import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';
import '../../../utils/utils.dart';

void main() {
  group('PreTrainingPage', () {
    final mockShowHintRepository = MockShowHintRepository();
    final mockKanaTypeRepository = MockKanaTypeRepository();
    final mockQuantityOfWordsRepository = MockQuantityOfWordsRepository();

    testWidgets('renders correctly', (tester) async {
      when(mockShowHintRepository.getShowHint).thenAnswer((_) => Future.value(true));
      when(mockKanaTypeRepository.getKanaType).thenAnswer((_) => Future.value(KanaType.both));
      when(mockQuantityOfWordsRepository.getQuantityOfWords).thenAnswer((_) => Future.value(5));

      await tester.pumpWidget(MaterialApp(
        localizationsDelegates: JStrings.localizationsDelegates,
        supportedLocales: JStrings.supportedLocales,
        home: PreTrainingPage(
          showHintRepository: mockShowHintRepository,
          kanaTypeRepository: mockKanaTypeRepository,
          quantityOfWordsRepository: mockQuantityOfWordsRepository,
        ),
      ));
      final strings = JStrings.of(tester.element(find.byType(PreTrainingPage)))!;

      tester
        ..expectWidget<FlexibleScaffold>()
        ..expectText(strings.preTrainingTitle)
        ..expectSvgPicture(BannerUrl.preTraining, indexInWidgets: 0)
        ..expectWidget<SliverFillRemaining>()
        ..expectWidget<ListView>()
        ..expectWidget<ShowHintTile>()
        ..expectWidget<KanaTypeTile>()
        ..expectWidget<QuantityOfWordsTile>()
        ..expectWidget<PlayButton>();
    });
  });

  group('PlayButton', () {
    testWidgets('', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        localizationsDelegates: JStrings.localizationsDelegates,
        supportedLocales: JStrings.supportedLocales,
        home: PlayButton(),
      ));

      tester
        ..expectWidget<MaterialButton>()
        ..expectSvgPicture(IconUrl.play, indexInWidgets: 0);
    });
  });
}
