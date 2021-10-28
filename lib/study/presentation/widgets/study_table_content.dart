import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:kwriting/study/study.dart';
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
    return Consumer<StudyTableChangeNotifier>(
      builder: (context, changeNotifier, child) {
        return TextButton(
          onPressed: _onContentPressed,
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(64, 64)),
            minimumSize: MaterialStateProperty.all(const Size(64, 64)),
            maximumSize: MaterialStateProperty.all(const Size(64, 64)),
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade50),
            overlayColor: MaterialStateProperty.all(Colors.transparent),
          ),
          child: FittedBox(
            fit: BoxFit.fill,
            child: Text(
              showKana ? widget.kana : widget.romaji,
              style: showKana ? const TextStyle(fontSize: 32, fontWeight: FontWeight.bold) : TextStyle(fontSize: Device.get().isTablet ? 24.0 : 18.0),
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
