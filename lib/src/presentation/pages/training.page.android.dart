import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/core/update_kana_situation.dart';
import 'package:kana_plus_plus/src/domain/controllers/training.controller.dart';
import 'package:kana_plus_plus/src/domain/controllers/writer.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/training_arguments.dart';
import 'package:kana_plus_plus/src/presentation/state_management/writer.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/training_kana.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/training_word.provider.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';
import 'package:kana_plus_plus/src/presentation/widgets/kana_viewers.dart';
import 'package:kana_plus_plus/src/presentation/widgets/writer.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TrainingPage extends StatelessWidget {
  TrainingPage({
    Key? key,
    required this.trainingController,
    required this.writerController,
  }) : super(key: key);

  final TrainingController trainingController;
  final WriterController writerController;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TrainingWordProvider()),
        ChangeNotifierProvider(create: (context) => TrainingKanaProvider(trainingController)),
        ChangeNotifierProvider(create: (context) => WriterProvider(writerController)),
      ],
      child: FutureBuilder<bool>(
        future: trainingController.isReady,
        builder: (context2, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return _buildLoader();
          }
          if (snapshot.hasError) {
            return _buildError(context2);
          }
          if (snapshot.hasData && snapshot.data! == true) {
            writerController.updateWriter(trainingController.currentKanaToWrite);
            return _buildData(context2);
          }
          return _buildNoData(context2);
        },
      ),
    );
  }

  Widget _buildData(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _buildQuitDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset(IconUrl.quitTraining, color: Theme.of(context).primaryIconTheme.color),
            onPressed: () => _buildQuitDialog(context),
          ),
        ),
        body: Column(
          children: [
            Consumer<TrainingWordProvider>(
              builder: (context, value, child) {
                return StepProgressIndicator(
                  currentStep: trainingController.wordIdx,
                  totalSteps: trainingController.quantityOfWords,
                  size: 5.0,
                  padding: 0.5,
                  selectedColor: Theme.of(context).accentColor,
                  unselectedColor: defaultProgressBarColor,
                );
              },
            ),
            Flexible(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: trainingController.numberOfWordsToStudy,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      const Spacer(),
                      Flexible(
                        flex: 10,
                        child: Consumer<TrainingWordProvider>(
                          builder: (context, value, child) {
                            return SvgPicture.asset(trainingController.wordImageUrl);
                          },
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: KanaViewers(trainingController: trainingController, wordIdxToShow: index),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        flex: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Consumer<WriterProvider>(
                            builder: (context, value, child) {
                              return Writer(
                                writerController: writerController,
                                onKanaRecovered: (pointsFiltered, kanaId) => _onKanaRecovered(pointsFiltered, kanaId, context),
                              );
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _buildQuitDialog(BuildContext context) {
    final strings = JStrings.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(strings.trainingQuitTitle),
        content: Text(strings.trainingQuitContent),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(strings.trainingQuitAnswerNo),
          ),
          TextButton(
            onPressed: () => Navigator.popUntil(context, ModalRoute.withName(Routes.menu)),
            child: Text(strings.trainingQuitAnswerYes),
          ),
        ],
      ),
    );
  }

  void _onKanaRecovered(List<List<Offset>> pointsFiltered, String kanaId, BuildContext context) {
    final kanaProvider = Provider.of<TrainingKanaProvider>(context, listen: false);
    final writerProvider = Provider.of<WriterProvider>(context, listen: false);
    final situation = kanaProvider.updateKana(pointsFiltered, kanaId);
    writerProvider.disable();
    Future.delayed(const Duration(milliseconds: 800)).then((value) {
      if (situation.isChangeKana) {
        _goToNextKana(context);
      } else if (situation.isChangeWord) {
        _goToNextWord(context);
      } else if (situation.isChangeTheLastWord) {
        _goToReviewPage(context);
      }
      writerProvider.enable();
    });
  }

  void _goToNextKana(BuildContext context) {
    _updateWriterData(context);
  }

  void _goToNextWord(BuildContext context) {
    _pageController
        .animateToPage(
      trainingController.wordIdx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    )
        .then((value) {
      final wordProvider = Provider.of<TrainingWordProvider>(context, listen: false);
      wordProvider.updateState();
      _updateWriterData(context);
    });
  }

  void _goToReviewPage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.review,
      ModalRoute.withName(Routes.menu),
      arguments: TrainingArguments(wordsResult: trainingController.wordsResult),
    );
  }

  void _updateWriterData(BuildContext context) {
    final writerProvider = Provider.of<WriterProvider>(context, listen: false);
    writerProvider.updateWriter(trainingController.currentKanaToWrite);
  }

  Widget _buildLoader() {
    return const Scaffold(body: SafeArea(child: Center(child: CircularProgressIndicator())));
  }

  Widget _buildError(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SvgPicture.asset(
          IconUrl.error,
          color: Theme.of(context).primaryIconTheme.color,
          width: Theme.of(context).primaryIconTheme.size,
          height: Theme.of(context).primaryIconTheme.size,
        ),
      ),
    );
  }

  Widget _buildNoData(BuildContext context) {
    return _buildError(context);
  }
}
