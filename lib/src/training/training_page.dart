import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/shared/icons.dart';
import 'package:kana_plus_plus/src/shared/images.dart';
import 'package:kana_plus_plus/src/shared/routes.dart';
import 'package:kana_plus_plus/src/training/kana_viewers.dart';
import 'package:kana_plus_plus/src/training/kana_writer.dart';
import 'package:kana_plus_plus/src/training/progress_bar.dart';
import 'package:kana_plus_plus/src/training/writing_hand.dart';

class TrainingPage extends StatefulWidget {
  @override
  _TrainingPageState createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  ////TEST
  int _maxCards = 20;
  int _currentCard = 0;
  int _currentSyllabe = 0;

  ///

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
              maxCards: _maxCards,
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
                  currentSyllabe: _currentSyllabe,
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
            Row(
              children: [
                ElevatedButton(
                    onPressed: () => setState(() {
                          _currentSyllabe += 1;
                        }),
                    child: const Text("next syllabe")),
                ElevatedButton(
                    onPressed: () => setState(() {
                          _currentCard += 1;
                        }),
                    child: const Text("next card")),
                ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, Routes.review),
                    child: const Text("test review")),
              ],
            ),
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
