import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/presentation/state_management/study_table.provider.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';
import 'package:provider/provider.dart';

class StudyTableContent extends StatefulWidget {
  const StudyTableContent({Key? key, required this.romaji, required this.kana}) : super(key: key);

  final String romaji;
  final String kana;

  @override
  _StudyTableContentState createState() => _StudyTableContentState();
}

class _StudyTableContentState extends State<StudyTableContent> {
  bool showKana = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<StudyTableProvider>(
      builder: (context, provider, child) {
        return TextButton(
          onPressed: _onContentPressed,
          style: studyTableContentButtonStyle,
          child: FittedBox(
            fit: BoxFit.fill,
            child: Text(
              provider.showAllKana || showKana ? widget.kana : widget.romaji,
              style: provider.showAllKana || showKana ? studyTableContentKanaTextStyle : studyTableContentRomajiTextStyle,
            ),
          ),
        );
      },
    );
  }

  void _onContentPressed() {
    if (!showKana) {
      setState(() {
        showKana = true;
      });
    }
  }
}
