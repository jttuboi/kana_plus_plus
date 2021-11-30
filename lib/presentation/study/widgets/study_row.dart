import 'package:flutter/material.dart';

import 'package:kwriting/presentation/study/study.dart';

class StudyRow extends StatelessWidget {
  const StudyRow(List<StudyData> contents, {Key? key})
      : _contents = contents,
        super(key: key);

  final List<StudyData> _contents;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: Colors.white),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _contents.map<Widget>((content) {
          return CustomPaint(
            painter: StudyContentPainter(empty: content == StudyData.empty, leftLetter: content.leftLetter, rightLetter: content.rightLetter),
            size: const Size.square(48),
          );
        }).toList(),
      ),
    );
  }
}
