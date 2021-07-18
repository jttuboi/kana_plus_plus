import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/models/selection_option.dart';
import 'package:kana_plus_plus/src/shared/icons.dart';
import 'package:kana_plus_plus/src/views/selection_option_page.dart';

class KanaTypeTile extends StatefulWidget {
  const KanaTypeTile(
    this.initialKanaIdx, {
    Key? key,
    required this.onOptionSelected,
  }) : super(key: key);

  final int initialKanaIdx;
  final Function(int) onOptionSelected;

  @override
  _KanaTypeTileState createState() => _KanaTypeTileState();
}

class _KanaTypeTileState extends State<KanaTypeTile> {
  late int _kanaSelectedIdx;

  final List<SelectionOption> _kanaOptions = [
    // AQUI localization icon
    const SelectionOption("Only hiragana", icon: JIcons.hiragana),
    const SelectionOption("Only katakana", icon: JIcons.katakana),
    const SelectionOption("Hiragana/Katakana", icon: JIcons.hiraganaKatakana),
  ];

  @override
  void initState() {
    _kanaSelectedIdx = widget.initialKanaIdx;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Kana type"), // AQUI localization
      subtitle: Text(_kanaOptions[_kanaSelectedIdx].title),
      leading: _kanaOptions[_kanaSelectedIdx].icon,
      onTap: () async {
        final selectedIdx = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectionOptionPage(
              title: "Select kana type", // AQUI localization
              optionSelectedIndex: _kanaSelectedIdx,
              options: _kanaOptions,
            ),
          ),
        );
        setState(() {
          _kanaSelectedIdx = selectedIdx as int;
          widget.onOptionSelected(_kanaSelectedIdx);
        });
      },
    );
  }
}
