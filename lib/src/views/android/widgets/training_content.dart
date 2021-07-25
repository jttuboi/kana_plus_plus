import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/models/kana_viewer_content.dart';
import 'package:kana_plus_plus/src/shared/images.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';
import 'package:kana_plus_plus/src/views/android/widgets/kana_viewers.dart';
import 'package:kana_plus_plus/src/views/android/widgets/kana_writer.dart';

class TrainingContent extends StatelessWidget {
  const TrainingContent({
    Key? key,
    required this.kanaIdx,
    required this.kanaViewerContents,
    required this.showHint,
  }) : super(key: key);

  final List<KanaViewerContent> kanaViewerContents;
  final int kanaIdx;
  final bool showHint;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              kanaViewerContents: kanaViewerContents,
              currentKanaIdx: kanaIdx,
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
              showHint: showHint,
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
