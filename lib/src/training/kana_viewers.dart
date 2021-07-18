import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/shared/images.dart';
import 'package:kana_plus_plus/src/training/kana_viewer.dart';
import 'package:kana_plus_plus/src/training/kana_viewer_status.dart';

class KanaViewers extends StatelessWidget {
  const KanaViewers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return KanaViewer(
          status: KanaViewerStatus.showCorrect,
          romaji: JImages.rA,
          kana: JImages.hA,
          userKana: JImages.hATest,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 5),
    );
  }
}
