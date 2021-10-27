import 'package:flutter/material.dart';
import 'package:kwriting/src/presentation/state_management/study_table.change_notifier.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:provider/provider.dart';

class StudyTableContent extends StatefulWidget {
  const StudyTableContent({required this.romaji, required this.kana, Key? key}) : super(key: key);

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
              showKana ? widget.kana : widget.romaji,
              style: showKana ? studyTableContentKanaTextStyle : studyTableContentRomajiTextStyle,
            ),
          ),
        );
      },
    );
  }

  void _onContentPressed() {
    setState(() {
      showKana = !showKana;
    });
  }
}
