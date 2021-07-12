import 'package:flutter/material.dart';
import 'package:kana_plus_plus/training/kana_viewers_widget.dart';
import 'package:kana_plus_plus/training/kana_writer_widget.dart';

class TrainingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 10),
        LinearProgressIndicator(
          value: 10,
          backgroundColor: Colors.white,
          minHeight: 8,
          color: Colors.green,
        ),
        Spacer(flex: 1),
        Container(
          color: Colors.amber,
          height: 320,
          width: 320,
        ),
        Spacer(flex: 1),
        KanaViewersWidget(),
        Spacer(flex: 1),
        KanaWriterWidget(
          writingHand: WritingHand.right,
        ),
        Spacer(flex: 1),
      ],
    );
  }
}
