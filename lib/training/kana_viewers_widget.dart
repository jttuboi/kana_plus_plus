import 'package:flutter/material.dart';
import 'package:kana_plus_plus/training/kana_viewer_widget.dart';

class KanaViewersWidget extends StatelessWidget {
  const KanaViewersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.0,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return KanaViewerWidget();
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 10);
        },
      ),
    );
  }
}
