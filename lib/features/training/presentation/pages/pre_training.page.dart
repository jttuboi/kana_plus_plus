import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_checker/kana_checker.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';
import 'package:kwriting/features/training/training.dart';
import 'package:provider/provider.dart';
import 'package:stroke_reducer/stroke_reducer.dart';

class PreTrainingPage extends StatelessWidget {
  const PreTrainingPage._(this._preTrainingController, {Key? key}) : super(key: key);

  static const routeName = '/pre_training';
  static const argPreTrainingController = 'argPreTrainingController';

  static Route route(PreTrainingController preTrainingController) {
    return MaterialPageRoute(builder: (context) => PreTrainingPage._(preTrainingController));
  }

  final PreTrainingController _preTrainingController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PreTrainingChangeNotifier(_preTrainingController)),
      ],
      builder: (context, child) => _PreTrainingPage(preTrainingController: _preTrainingController),
    );
  }
}

class _PreTrainingPage extends StatelessWidget {
  _PreTrainingPage({
    required this.preTrainingController,
    Key? key,
  }) : super(key: key);

  final preTrainingPlayIconThemeData = IconThemeData(
    color: Colors.grey.shade300,
    size: 40,
  );

  final PreTrainingController preTrainingController;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return FlexibleScaffold(
      isFlexible: false,
      title: strings.preTrainingTitle,
      bannerUrl: BannerUrl.preTraining,
      onBackButtonPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
      sliverContent: SliverFillRemaining(
        child: Consumer<PreTrainingChangeNotifier>(
          builder: (context, changeNotifier, child) {
            return ListView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(height: 8),
                // ShowHintTile(
                //   showHint: preTrainingController.showHint,
                //   iconUrl: preTrainingController.showHintIconUrl,
                //   updateShowHint: changeNotifier.updateShowHint,
                // ),
                // KanaTypeTile(
                //   kanaType: preTrainingController.kanaType,
                //   iconUrl: preTrainingController.kanaTypeIconUrl,
                //   options: changeNotifier.getKanaTypeOptions,
                //   updateKanaType: changeNotifier.updateKanaType,
                // ),
                // QuantityOfWordsTile(
                //   quantity: preTrainingController.quantityOfWords,
                //   updateQuantity: changeNotifier.updateQuantity,
                // ),
                MaterialButton(
                  color: Theme.of(context).colorScheme.secondary,
                  shape: const CircleBorder(),
                  onPressed: () {
                    final kanaChecker = KanaChecker();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      TrainingPage.routeName,
                      (route) => route.isFirst,
                      arguments: {
                        TrainingPage.argTrainingController: TrainingController(
                          wordRepository: WordRepository(),
                          statisticsRepository: StatisticsRepository(),
                          kanaChecker: kanaChecker,
                          showHint: preTrainingController.showHint,
                          kanaType: preTrainingController.kanaType,
                          quantityOfWords: preTrainingController.quantityOfWords,
                        ),
                        TrainingPage.argWriterController: WriterController(
                          writingHandRepository: WritingHandRepository(),
                          strokeReducer: StrokeReducer(minPointsQuantity: 20),
                          kanaChecker: kanaChecker,
                          showHint: preTrainingController.showHint,
                        ),
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SvgPicture.asset(
                      IconUrl.play,
                      color: preTrainingPlayIconThemeData.color,
                      width: preTrainingPlayIconThemeData.size,
                      height: preTrainingPlayIconThemeData.size,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
