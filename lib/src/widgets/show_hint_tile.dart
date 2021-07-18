import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/shared/icons.dart';

class ShowHintTile extends StatefulWidget {
  const ShowHintTile(
    // ignore: avoid_positional_boolean_parameters
    this.initialValue, {
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final bool initialValue;
  final Function(bool) onChanged;

  @override
  _ShowHintTileState createState() => _ShowHintTileState();
}

class _ShowHintTileState extends State<ShowHintTile> {
  late bool _showHint;

  @override
  void initState() {
    _showHint = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: const Text("Show hint"), // AQUI localization
      value: _showHint,
      onChanged: (value) => setState(() {
        _showHint = value;
        widget.onChanged(_showHint);
      }),
      secondary: JIcons.showHint,
    );
  }
}
