import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/training/training.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage(this._trainingController, this._writerController, {Key? key}) : super(key: key);

  static const routeName = '/training';
  static const argTrainingController = 'argTrainingController';
  static const argWriterController = 'argWriterController';

  static Route route(TrainingController trainingController, WriterController writerController) {
    return MaterialPageRoute(builder: (context) => TrainingPage(trainingController, writerController));
  }

  final TrainingController _trainingController;
  final WriterController _writerController;

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TrainingWordChangeNotifier>(create: (context) => TrainingWordChangeNotifier()),
        ChangeNotifierProvider<TrainingKanaChangeNotifier>(create: (context) => TrainingKanaChangeNotifier(widget._trainingController)),
        ChangeNotifierProvider<WriterChangeNotifier>(create: (context) => WriterChangeNotifier(widget._writerController)),
      ],
      child: FutureBuilder<bool>(
        future: widget._trainingController.isReady,
        builder: (context2, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return _buildLoader();
          }
          if (snapshot.hasError) {
            return _buildError(context2);
          }
          if (snapshot.hasData && snapshot.data! == true) {
            widget._writerController.updateWriter(widget._trainingController.currentKanaToWrite);
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
            Consumer<TrainingWordChangeNotifier>(
              builder: (context, value, child) {
                return StepProgressIndicator(
                  currentStep: widget._trainingController.wordIdx,
                  totalSteps: widget._trainingController.quantityOfWords,
                  size: Device.get().isTablet ? 6.0 : 5.0,
                  padding: 0.5,
                  selectedColor: Theme.of(context).colorScheme.secondary,
                  unselectedColor: Colors.grey.shade400,
                );
              },
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget._trainingController.numberOfWordsToStudy,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          const Spacer(),
                          Consumer<TrainingWordChangeNotifier>(
                            builder: (context, value, child) {
                              return GestureDetector(
                                onTap: () => {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(widget._trainingController.wordTranslate),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  ),
                                },
                                child: SvgPicture.asset(widget._trainingController.wordImageUrl, height: constraints.maxHeight * 10 / 30),
                              );
                            },
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: KanaViewers(
                              width: constraints.maxWidth - 16.0 * 2, // 16 * 2 is the padding size for this content
                              height: constraints.maxHeight * 4 / 30,
                              trainingController: widget._trainingController,
                              wordIdxToShow: index,
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 32),
                            child: Row(
                              children: [
                                const Spacer(),
                                Consumer<WriterChangeNotifier>(
                                  builder: (context, value, child) {
                                    return Writer(
                                      writerController: widget._writerController,
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
            onPressed: () => Navigator.pop(context, false),
            child: Text(strings.trainingQuitAnswerNo),
          ),
          TextButton(
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            child: Text(strings.trainingQuitAnswerYes),
          ),
        ],
      ),
    );
  }

  void _onKanaRecovered(List<List<Offset>> pointsFiltered, String kanaId, BuildContext context) {
    final kanaChangeNotifier = Provider.of<TrainingKanaChangeNotifier>(context, listen: false);
    final writerChangeNotifier = Provider.of<WriterChangeNotifier>(context, listen: false);
    final situation = kanaChangeNotifier.updateKana(pointsFiltered, kanaId);
    writerChangeNotifier.disable();
    Future.delayed(const Duration(milliseconds: 800)).then((value) {
      if (situation.isChangeKana) {
        _goToNextKana(context);
      } else if (situation.isChangeWord) {
        _goToNextWord(context);
      } else if (situation.isChangeTheLastWord) {
        _goToReviewPage(context);
      }
      writerChangeNotifier.enable();
    });
  }

  void _goToNextKana(BuildContext context) {
    _updateWriterData(context);
  }

  void _goToNextWord(BuildContext context) {
    _pageController
        .animateToPage(
      widget._trainingController.wordIdx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    )
        .then((value) {
      Provider.of<TrainingWordChangeNotifier>(context, listen: false).updateState();
      _updateWriterData(context);
    });
  }

  void _goToReviewPage(BuildContext context) {
    final wordsResult = widget._trainingController.wordsResult;
    widget._trainingController.updateStatistics(wordsResult);

    Navigator.pushNamedAndRemoveUntil(
      context,
      ReviewPage.routeName,
      (route) => route.isFirst,
      arguments: {
        ReviewPage.argReviewController: ReviewController(statisticsRepository: StatisticsRepository()),
        ReviewPage.argWordsResult: wordsResult,
      },
    );
  }

  void _updateWriterData(BuildContext context) {
    Provider.of<WriterChangeNotifier>(context, listen: false).updateWriter(widget._trainingController.currentKanaToWrite);
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
