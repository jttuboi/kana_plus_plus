import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/enums/update_kana_situation.dart';
import 'package:kana_plus_plus/src/domain/usecases/training.controller.dart';
import 'package:kana_plus_plus/src/domain/usecases/writer.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/training_arguments.dart';
import 'package:kana_plus_plus/src/presentation/state_management/writer.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/training_kana_state_management.dart';
import 'package:kana_plus_plus/src/presentation/state_management/training_word.state_management.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';
import 'package:kana_plus_plus/src/presentation/widgets/kana_viewers.dart';
import 'package:kana_plus_plus/src/presentation/widgets/writer.dart';
import 'package:kana_plus_plus/src/presentation/widgets/progress_bar.dart';
import 'package:provider/provider.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({
    Key? key,
    required this.trainingController,
    required this.writerController,
  }) : super(key: key);

  final TrainingController trainingController;
  final WriterController writerController;

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  late final TrainingWordStateManagement wordStateManagement;
  late final TrainingKanaStateManagement kanaStateManagement;
  late final WriterProvider writerProvider;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    wordStateManagement = TrainingWordStateManagement(widget.trainingController);
    kanaStateManagement = TrainingKanaStateManagement(widget.trainingController);
    writerProvider = WriterProvider(widget.writerController);
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _buildQuitDialog(context);
        return false;
      },
      child: FutureBuilder<bool>(
        future: wordStateManagement.isReady,
        builder: (context2, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return _buildLoader();
          }
          if (snapshot.hasError) {
            return _buildError();
          }
          if (snapshot.hasData && snapshot.data! == true) {
            _updateWriterData();
            return _buildData(context);
          }
          return _buildNoData();
        },
      ),
    );
  }

  Widget _buildData(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white.withOpacity(0.0),
        backgroundColor: Colors.white.withOpacity(0.0),
        //elevation: 0.1,
        leading: IconButton(
          icon: const ImageIcon(AssetImage(IconUrl.quitTraining)),
          onPressed: () => _buildQuitDialog(context),
        ),
      ),
      body: Column(
        children: [
          AnimatedBuilder(
            animation: wordStateManagement,
            builder: (context, child) {
              return ProgressBar(
                wordStateManagement.wordIdx,
                maxWords: wordStateManagement.maxQuantityOfWords,
              );
            },
          ),
          Flexible(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: wordStateManagement.numberOfWordsToStudy,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const Spacer(),
                    Flexible(
                      flex: 10,
                      child: _buildPicture(),
                    ),
                    const Spacer(),
                    Flexible(
                      flex: 4,
                      child: _buildKanaViewers(index),
                    ),
                    const Spacer(),
                    Flexible(
                      flex: 12,
                      child: _buildWriter(context),
                    ),
                    const Spacer(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPicture() {
    return AnimatedBuilder(
      animation: wordStateManagement,
      builder: (context, child) {
        return Image.asset(wordStateManagement.currentImageUrl);
      },
    );
  }

  Widget _buildKanaViewers(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: KanaViewers(
        stateManagement: kanaStateManagement,
        wordIdxToShow: index,
      ),
    );
  }

  Widget _buildWriter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: ChangeNotifierProvider(
        create: (context) => writerProvider,
        child: Writer(
          writerProvider: writerProvider,
          writerController: widget.writerController,
          onKanaRecovered: (pointsFiltered, kanaId) => _onKanaRecovered(pointsFiltered, kanaId, context),
        ),
      ),
    );
  }

  void _onKanaRecovered(List<List<Offset>> pointsFiltered, String kanaId, BuildContext context) {
    final situation = kanaStateManagement.updateKana(pointsFiltered, kanaId);
    writerProvider.disable();
    Future.delayed(const Duration(milliseconds: 800)).then((value) {
      if (situation.isChangeKana) {
        _goToNextKana();
      } else if (situation.isChangeWord) {
        _goToNextWord();
      } else if (situation.isChangeTheLastWord) {
        _goToReviewPage(context);
      }
      writerProvider.enable();
    });
  }

  void _goToNextKana() {
    _updateWriterData();
  }

  void _goToNextWord() {
    _pageController
        .animateToPage(
      wordStateManagement.wordIdx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.linear,
    )
        .then((value) {
      wordStateManagement.updateState();
      _updateWriterData();
    });
  }

  void _goToReviewPage(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.review,
      arguments: TrainingArguments(
        wordsResult: wordStateManagement.wordsResult,
      ),
    );
  }

  void _updateWriterData() {
    writerProvider.updateWriter(kanaStateManagement.currentKanaToWrite);
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

  void _buildQuitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        // TODO strings
        title: const Text('Do you want to finish your training?'),
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

//