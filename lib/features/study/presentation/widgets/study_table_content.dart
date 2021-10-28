import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class StudyTableContent extends StatefulWidget {
  const StudyTableContent({required String romaji, required String kana, Key? key})
      : _romaji = romaji,
        _kana = kana,
        super(key: key);

  final String _romaji;
  final String _kana;

  @override
  _StudyTableContentState createState() => _StudyTableContentState();
}

class _StudyTableContentState extends State<StudyTableContent> {
  bool _showKana = false;

  @override
  Widget build(BuildContext context) {
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
          _showKana ? widget._kana : widget._romaji,
          style: _showKana ? const TextStyle(fontSize: 32, fontWeight: FontWeight.bold) : TextStyle(fontSize: Device.get().isTablet ? 24.0 : 18.0),
        ),
      ),
    );
  }

  void _onContentPressed() {
    setState(() {
      _showKana = !_showKana;
    });
  }
}
