import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/settings/selection_option.dart';

class SelectionOptionPage extends StatefulWidget {
  const SelectionOptionPage({
    Key? key,
    required this.title,
    required this.optionSelectedIndex,
    required this.options,
  }) : super(key: key);

  final String title;
  final int optionSelectedIndex;
  final List<SelectionOption> options;

  @override
  _SelectionOptionPageState createState() => _SelectionOptionPageState();
}

class _SelectionOptionPageState extends State<SelectionOptionPage> {
  late int _optionSelectedIndex;

  @override
  void initState() {
    _optionSelectedIndex = (widget.optionSelectedIndex < widget.options.length)
        ? widget.optionSelectedIndex
        : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, _optionSelectedIndex);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: widget.options.length,
          itemBuilder: (context, index) {
            final option = widget.options[index];
            return RadioListTile(
              title: Text(option.title),
              value: index,
              groupValue: _optionSelectedIndex,
              onChanged: (value) {
                setState(() {
                  _optionSelectedIndex = value! as int;
                });
                Navigator.pop(context, _optionSelectedIndex);
              },
              secondary: option.icon,
              controlAffinity: ListTileControlAffinity.trailing,
            );
          },
        ),
      ),
    );
  }
}
