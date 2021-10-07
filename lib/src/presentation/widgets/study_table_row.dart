import 'package:flutter/widgets.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:kwriting/src/presentation/widgets/study_table_content.dart';

class StudyTableRow extends StatelessWidget {
  const StudyTableRow({Key? key, this.a, this.i, this.u, this.e, this.o}) : super(key: key);

  final List<String>? a;
  final List<String>? i;
  final List<String>? u;
  final List<String>? e;
  final List<String>? o;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: studyTableRowDecoration,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: studyTableRowHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (a != null) StudyTableContent(romaji: a![0], kana: a![1]),
          if (i != null) StudyTableContent(romaji: i![0], kana: i![1]),
          if (u != null) StudyTableContent(romaji: u![0], kana: u![1]),
          if (e != null) StudyTableContent(romaji: e![0], kana: e![1]),
          if (o != null) StudyTableContent(romaji: o![0], kana: o![1]),
        ],
      ),
    );
  }
}
