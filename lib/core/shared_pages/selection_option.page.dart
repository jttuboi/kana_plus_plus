import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/core.dart';

class SelectionOptionPage extends StatelessWidget {
  const SelectionOptionPage._({required this.arguments, Key? key}) : super(key: key);

  static const routeName = '/selection_option';
  static const argSelectionOptionArgs = 'selectionOptionArgs';

  static Route route(SelectionOptionArgs selectionOptionArgs) {
    return MaterialPageRoute(builder: (context) => SelectionOptionPage._(arguments: selectionOptionArgs));
  }

  final SelectionOptionArgs arguments;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        arguments.onSelected(arguments.selectedOptionKey);
        Navigator.pop(context);
        return false;
      },
      child: FlexibleScaffold(
        isFlexible: false,
        title: arguments.title,
        bannerUrl: arguments.bannerUrl,
        onBackButtonPressed: () => Navigator.pop(context),
        sliverContent: SliverFillRemaining(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: arguments.options.length,
            itemBuilder: (context, index) {
              final option = arguments.options[index];
              return RadioListTile(
                title: Text(option.label),
                value: index,
                groupValue: arguments.options.indexWhere((pOption) {
                  return pOption.key == arguments.selectedOptionKey;
                }),
                onChanged: (value) {
                  arguments.onSelected(arguments.options[value! as int].key);
                  Navigator.pop(context);
                },
                secondary: option.iconUrl.isEmpty ? null : SvgPicture.asset(option.iconUrl, color: defaultTileIconColor, width: defaultTileIconSize),
                controlAffinity: ListTileControlAffinity.trailing,
              );
            },
          ),
        ),
      ),
    );
  }
}
