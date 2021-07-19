import 'dart:math';

import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/models/kana_result.dart';
import 'package:kana_plus_plus/src/models/training_arguments.dart';
import 'package:kana_plus_plus/src/shared/icons.dart';
import 'package:kana_plus_plus/src/shared/images.dart';
import 'package:kana_plus_plus/src/shared/routes.dart';
import 'package:kana_plus_plus/src/models/kana_viewer_content.dart';
import 'package:kana_plus_plus/src/shared/kana_viewer_status.dart';
import 'package:kana_plus_plus/src/widgets/kana_viewers.dart';
import 'package:kana_plus_plus/src/widgets/kana_writer.dart';
import 'package:kana_plus_plus/src/widgets/progress_bar.dart';
import 'package:kana_plus_plus/src/shared/writing_hand.dart';

class TrainingPage extends StatefulWidget {
  const TrainingPage({
    Key? key,
    required this.showHint,
    required this.kanaType,
    required this.quantityOfCards,
  }) : super(key: key);

  final bool showHint;
  final int kanaType;
  final int quantityOfCards;

  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  //////////////////////////////////////////////////TEST
  int _wordIdx = 0;
  int _kanaIdx = 0;

  final List<List<KanaViewerContent>> _listOfKanaViewerContents = [];

  void _generateDataForTest() {
    for (int i = 0; i < widget.quantityOfCards; i++) {
      final List<KanaViewerContent> kanas = [];
      final int maxKanas = Random().nextInt(9) + 2;
      for (int j = 0; j < maxKanas; j++) {
        kanas.add(
          KanaViewerContent(
            status: (j == 0)
                ? KanaViewerStatus.showSelected
                : KanaViewerStatus.showInitial,
            romaji: JImages.rA,
            kana: JImages.hA,
          ),
        );
      }
      _listOfKanaViewerContents.add(kanas);
    }
  }

  void _test() {
    setState(() {
      final kanasContent = _listOfKanaViewerContents[_wordIdx];

      // gera o que o kana view deve mostrar apos escrito kana writer
      final preview = kanasContent[_kanaIdx];
      kanasContent[_kanaIdx] = KanaViewerContent(
        status: (Random().nextBool())
            ? KanaViewerStatus.showCorrect
            : KanaViewerStatus.showWrong,
        romaji: preview.romaji,
        kana: preview.kana,
        userKana: JImages.hATest,
      );

      // muda pro proximo e atualiza para select
      _kanaIdx += 1;
      if (_kanaIdx < kanasContent.length) {
        final preview2 = kanasContent[_kanaIdx];
        kanasContent[_kanaIdx] = KanaViewerContent(
          status: KanaViewerStatus.showSelected,
          romaji: preview2.romaji,
          kana: preview2.kana,
        );
      } else {
        // se chegou no fim, reseta e muda pra prox palavra
        _kanaIdx = 0;
        _wordIdx += 1;
      }
    });

    // se não tem mais palavras, sai do training
    if (_wordIdx >= _listOfKanaViewerContents.length) {
      final List<List<KanaResult>> wordsResult = [];
      for (int i = 0; i < _listOfKanaViewerContents.length; i++) {
        final kanasContent = _listOfKanaViewerContents[i];
        final List<KanaResult> kanasResult = [];
        for (int j = 0; j < kanasContent.length; j++) {
          final kanaContent = kanasContent[j];
          kanasResult.add(
            KanaResult(
              correct: kanaContent.status.isShowCorrect,
              kana: kanaContent.kana,
              // algo assim nao deve acontecer, ver como melhorar essa parte
              userKana: kanaContent.userKana ?? JImages.empty,
            ),
          );
        }
        wordsResult.add(kanasResult);
      }

      // para evitar que a página de treino tente acessar os dados de um elemento
      // não existente
      _wordIdx = 0;

      Navigator.pushNamed(
        context,
        Routes.review,
        arguments: TrainingArguments(
          wordsResult: wordsResult,
        ),
      );
    }
  }

  @override
  void initState() {
    _generateDataForTest();
    super.initState();
  }
  ////////////////////////////////////////////////// TESTE

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _buildQuitDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          shadowColor: Colors.white.withOpacity(0.0),
          backgroundColor: Colors.white.withOpacity(0.0),
          leading: IconButton(
            icon: JIcons.quit,
            onPressed: () => _buildQuitDialog(context),
          ),
        ),
        body: Column(
          children: [
            ProgressBar(
              _wordIdx,
              maxCards: widget.quantityOfCards,
            ),
            const Spacer(),
            Flexible(
              flex: 10,
              child: JImages.rain,
            ),
            const Spacer(),
            Flexible(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: KanaViewers(
                  kanaViewerContents: _listOfKanaViewerContents[_wordIdx],
                  currentKanaIdx: _kanaIdx,
                ),
              ),
            ),
            const Spacer(),
            Flexible(
              flex: 12,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: KanaWriter(
                  writingHand: WritingHand.right,
                  showHint: widget.showHint,
                ),
              ),
            ),
            const Spacer(),
            ////////////////////////////// TEST
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _test(),
                  child: const Text("next Kana"),
                ),
                ElevatedButton(
                    onPressed: () => Navigator.pushNamed(
                          context,
                          Routes.review,
                          arguments: const TrainingArguments(wordsResult: []),
                        ),
                    child: const Text("go to review")),
              ],
            ),
            ////////////////////////////// TEST
          ],
        ),
      ),
    );
  }

  void _buildQuitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Do you want to finish your training?"),
        content: const Text("You're going to lost this training data."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }
}
