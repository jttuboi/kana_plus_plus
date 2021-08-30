import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/presentation/arguments/selection_option.arguments.dart';

class SelectionOptionPage extends StatelessWidget {
  const SelectionOptionPage({
    Key? key,
    required this.title,
    required this.selectedOptionKey,
    required this.options,
    required this.onSelected,
  }) : super(key: key);

  final String title;
  final dynamic selectedOptionKey;
  final List<SelectionOptionArguments> options;
  final Function(dynamic) onSelected;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onSelected(selectedOptionKey);
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        // TODO mudar o app bar ou pelo menos a cor dele
        appBar: AppBar(title: Text(title)),
        body: ListView.builder(
          itemCount: options.length,
          itemBuilder: (context, index) {
            final option = options[index];
            return RadioListTile(
              title: Text(option.label),
              value: index,
              groupValue: options.indexWhere((SelectionOptionArguments pOption) {
                return pOption.key == selectedOptionKey;
              }),
              onChanged: (int? value) {
                onSelected(options[value!].key);
                Navigator.pop(context);
              },
              secondary: (option.iconUrl.isNotEmpty) ? ImageIcon(AssetImage(option.iconUrl)) : null,
              controlAffinity: ListTileControlAffinity.trailing,
            );
          },
        ),
      ),
    );
  }
}
