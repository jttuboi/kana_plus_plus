import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_checker/kana_checker.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/training/training.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:provider/provider.dart';
import 'package:stroke_reducer/stroke_reducer.dart';

class PreTrainingPage extends StatelessWidget {
  const PreTrainingPage._({Key? key}) : super(key: key);

  static const routeName = '/pre_training';

  static Route route() {
    return MaterialPageRoute(builder: (context) => const PreTrainingPage._());
  }

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ShowHintChangeNotifier(ShowHintRepository(), mustPersist: false)),
        ChangeNotifierProvider(create: (context) => KanaTypeChangeNotifier(KanaTypeRepository(), mustPersist: false)),
        ChangeNotifierProvider(create: (context) => QuantityOfWordsChangeNotifier(QuantityOfWordsRepository(), mustPersist: false)),
      ],
      builder: (context, child) {
        return FlexibleScaffold(
          isFlexible: false,
          title: strings.preTrainingTitle,
          bannerUrl: BannerUrl.preTraining,
          onBackButtonPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
          sliverContent: SliverFillRemaining(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 8),
                ShowHintTile(),
                KanaTypeTile(),
                QuantityOfWordsTile(),
                _PlayButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _PlayButton extends StatelessWidget {
  const _PlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).colorScheme.secondary,
      shape: const CircleBorder(),
      onPressed: () => _onPlayClicked(context),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SvgPicture.asset(IconUrl.play, color: Colors.grey.shade300, width: 40, height: 40),
      ),
    );
  }

  void _onPlayClicked(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      TrainingPage.routeName,
      (route) => route.isFirst,
      arguments: {
        TrainingPage.argTrainingController: TrainingController(
          wordRepository: WordRepository(),
          statisticsRepository: StatisticsRepository(),
          kanaChecker: KanaChecker(),
          showHint: context.read<ShowHintChangeNotifier>().data.showHint,
          kanaType: context.read<KanaTypeChangeNotifier>().data.kanaType,
          quantityOfWords: context.read<QuantityOfWordsChangeNotifier>().quantity,
        ),
        TrainingPage.argWriterController: WriterController(
          writingHandRepository: WritingHandRepository(),
          strokeReducer: StrokeReducer(maxPointsQuantity: 20),
          kanaChecker: KanaChecker(),
          showHint: context.read<ShowHintChangeNotifier>().data.showHint,
        ),
      },
    );
  }
}
