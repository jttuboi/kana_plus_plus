import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/enums/update_kana_situation.dart';
import 'package:kana_plus_plus/src/domain/usecases/training.controller.dart';
import 'package:kana_plus_plus/src/domain/usecases/writer.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/training_arguments.dart';
import 'package:kana_plus_plus/src/presentation/state_management/writer.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/training_kana.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/training_word.provider.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';
import 'package:kana_plus_plus/src/presentation/widgets/kana_viewers.dart';
import 'package:kana_plus_plus/src/presentation/widgets/writer.dart';
import 'package:kana_plus_plus/src/presentation/widgets/progress_bar.dart';
import 'package:provider/provider.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({
    Key? key,
    required this.trainingController,
    required this.writerController,
  }) : super(key: key);

  final TrainingController trainingController;
  final WriterController writerController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TrainingWordProvider()),
        ChangeNotifierProvider(create: (context) => TrainingKanaProvider(trainingController)),
        ChangeNotifierProvider(create: (context) => WriterProvider(writerController)),
      ],
      child: WillPopScope(
        onWillPop: () async {
          _buildQuitDialog(context);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.white.withOpacity(0.0),
            backgroundColor: Colors.white.withOpacity(0.0),
            //elevation: 0.1,
            leading: IconButton(
              icon: const ImageIcon(AssetImage(IconUrl.quitTraining)),
              onPressed: () => _buildQuitDialog(context),
            ),
          ),
          body: _TrainingPage(
            trainingController: trainingController,
            writerController: writerController,
          ),
        ),
      ),
    );
  }

  void _buildQuitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Do you want to finish your training?'), // TODO strings
        content: const Text('You are going to lost this training data.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'), // TODO strings
          ),
          TextButton(
            onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text('Yes'), // TODO strings
          ),
        ],
      ),
    );
  }
}

class _TrainingPage extends StatelessWidget {
  _TrainingPage({
    Key? key,
    required this.trainingController,
    required this.writerController,
  }) : super(key: key);

  final TrainingController trainingController;
  final WriterController writerController;

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: trainingController.isReady,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return _buildLoader();
        }
        if (snapshot.hasError) {
          return _buildError();
        }
        if (snapshot.hasData && snapshot.data! == true) {
          _updateWriterData(context);
          return _buildData(context);
        }
        return _buildNoData();
      },
    );
  }

  Widget _buildData(BuildContext context) {
    return Column(
      children: [
        Consumer<TrainingWordProvider>(
          builder: (context, value, child) {
            return ProgressBar(
              trainingController.wordIdx,
              maxWords: trainingController.quantityOfWords,
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
                        return Image.asset(trainingController.currentImageUrl);
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
    Navigator.pushNamed(context, Routes.review, arguments: TrainingArguments(wordsResult: trainingController.wordsResult));
  }

  void _updateWriterData(BuildContext context) {
    final writerProvider = Provider.of<WriterProvider>(context, listen: false);
    writerProvider.updateWriter(trainingController.currentKanaToWrite);
  }

  Widget _buildLoader() {
    // TODO colocar shimmer aqui
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildError() {
    return const Center(child: Icon(Icons.error));
  }

  Widget _buildNoData() {
    return const Center(child: Icon(Icons.cloud_off));
  }
}
