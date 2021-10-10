import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/src/data/datasources/icon_url.storage.dart';
import 'package:kwriting/src/domain/controllers/training.controller.dart';
import 'package:kwriting/src/domain/controllers/writer.controller.dart';
import 'package:kwriting/src/domain/utils/update_kana_situation.dart';
import 'package:kwriting/src/presentation/arguments/training_arguments.dart';
import 'package:kwriting/src/presentation/state_management/training_kana.provider.dart';
import 'package:kwriting/src/presentation/state_management/training_word.provider.dart';
import 'package:kwriting/src/presentation/state_management/writer.provider.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:kwriting/src/presentation/utils/routes.dart';
import 'package:kwriting/src/presentation/widgets/kana_viewers.dart';
import 'package:kwriting/src/presentation/widgets/writer.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({
    Key? key,
    required this.trainingController,
    required this.writerController,
  }) : super(key: key);

  final TrainingController trainingController;
  final WriterController writerController;

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TrainingWordProvider>(create: (context) => TrainingWordProvider()),
        ChangeNotifierProvider<TrainingKanaProvider>(create: (context) => TrainingKanaProvider(widget.trainingController)),
        ChangeNotifierProvider<WriterProvider>(create: (context) => WriterProvider(widget.writerController)),
      ],
      child: FutureBuilder<bool>(
        future: widget.trainingController.isReady,
        builder: (context2, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return _buildLoader();
          }
          if (snapshot.hasError) {
            return _buildError(context2);
          }
          if (snapshot.hasData && snapshot.data! == true) {
            widget.writerController.updateWriter(widget.trainingController.currentKanaToWrite);
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
                  currentStep: widget.trainingController.wordIdx,
                  totalSteps: widget.trainingController.quantityOfWords,
                  size: stepProgressIndicatorSize,
                  padding: 0.5,
                  selectedColor: Theme.of(context).colorScheme.secondary,
                  unselectedColor: defaultProgressBarColor,
                );
              },
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.trainingController.numberOfWordsToStudy,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const Spacer(),
                          Consumer<TrainingWordProvider>(
                            builder: (context, value, child) {
                              return GestureDetector(
                                onTap: () => {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(widget.trainingController.wordTranslate),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  ),
                                },
                                child: SvgPicture.asset(widget.trainingController.wordImageUrl, height: constraints.maxHeight * 10 / 30),
                              );
                            },
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: KanaViewers(
                              width: constraints.maxWidth - 16.0 * 2, // 16 * 2 is the padding size for this content
                              height: constraints.maxHeight * 4 / 30,
                              trainingController: widget.trainingController,
                              wordIdxToShow: index,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32.0),
                            child: Row(
                              children: [
                                const Spacer(),
                                Consumer<WriterProvider>(
                                  builder: (context, value, child) {
                                    return Writer(
                                      writerController: widget.writerController,
                                      width: constraints.maxWidth - 32.0 * 2, // 32 * 2 is the padding size for this content
                                      height: constraints.maxHeight * 12 / 30,
                                      onKanaRecovered: (pointsFiltered, kanaId) => _onKanaRecovered(pointsFiltered, kanaId, context),
                                    );
                                  },
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      );
                    },
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
      widget.trainingController.wordIdx,
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
    final wordsResult = widget.trainingController.wordsResult;
    widget.trainingController.updateStatistics(wordsResult);

    Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.review,
      ModalRoute.withName(Routes.menu),
      arguments: TrainingArguments(wordsResult: wordsResult),
    );
  }

  void _updateWriterData(BuildContext context) {
    final writerProvider = Provider.of<WriterProvider>(context, listen: false);
    writerProvider.updateWriter(widget.trainingController.currentKanaToWrite);
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
