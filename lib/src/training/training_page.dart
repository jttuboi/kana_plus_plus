import 'dart:math';

import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/shared/icons.dart';
import 'package:kana_plus_plus/src/shared/images.dart';
import 'package:kana_plus_plus/src/shared/routes.dart';
import 'package:kana_plus_plus/src/training/kana_viewer_content.dart';
import 'package:kana_plus_plus/src/training/kana_viewer_status.dart';
import 'package:kana_plus_plus/src/training/kana_viewers.dart';
import 'package:kana_plus_plus/src/training/kana_writer.dart';
import 'package:kana_plus_plus/src/training/progress_bar.dart';
import 'package:kana_plus_plus/src/training/writing_hand.dart';

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
  int _currentCard = 0;
  int _currentKanaIdx = 0;

  late List<KanaViewerContent> _kanaViewerContents;

  List<KanaViewerContent> generateKanaViewerContents() {
    final List<KanaViewerContent> list = [];
    final int maxKanas = Random().nextInt(9) + 2;
    for (int i = 0; i < maxKanas; i++) {
      list.add(
        KanaViewerContent(
            status: KanaViewerStatus.showInitial,
            romaji: JImages.rA,
            kana: JImages.hA),
      );
    }
    return list;
  }

  @override
  void initState() {
    _kanaViewerContents = generateKanaViewerContents();
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
          title: const Text("training"),
          leading: IconButton(
            icon: JIcons.quit,
            onPressed: () => _buildQuitDialog(context),
          ),
        ),
        body: Column(
          children: [
            ProgressBar(
              _currentCard,
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
                  kanaViewerContents: _kanaViewerContents,
                  currentKanaIdx: _currentKanaIdx,
                ),
              ),
            ),
            const Spacer(),
            const Flexible(
              flex: 12,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0),
                child: KanaWriter(
                  writingHand: WritingHand.right,
                ),
              ),
            ),
            const Spacer(),
            ////////////////////////////// TEST
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _kanaViewerContents[_currentKanaIdx] =
                            KanaViewerContent(
                          status: KanaViewerStatus.showCorrect,
                          romaji: JImages.rA,
                          kana: JImages.hA,
                          userKana: JImages.hATest,
                        );
                        _currentKanaIdx += 1;
                        if (_currentKanaIdx >= _kanaViewerContents.length) {
                          _kanaViewerContents = generateKanaViewerContents();
                          _currentKanaIdx = 0;
                          _currentCard += 1;
                        }
                      });
                      if (_currentCard >= widget.quantityOfCards) {
                        Navigator.pushNamed(context, Routes.review);
                      }
                    },
                    child: const Text("next Kana")),
                ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.review),
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
