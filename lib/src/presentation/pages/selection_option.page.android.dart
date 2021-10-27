import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/src/presentation/arguments/selection_option_arguments.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:kwriting/src/presentation/widgets/flexible_scaffold.dart';

class SelectionOptionPage extends StatelessWidget {
  const SelectionOptionPage({
    required this.title,
    required this.bannerUrl,
    required this.selectedOptionKey,
    required this.options,
    required this.onSelected,
    Key? key,
  }) : super(key: key);

  final String title;
  final String bannerUrl;
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
      child: FlexibleScaffold(
        isFlexible: false,
        title: title,
        bannerUrl: bannerUrl,
        onBackButtonPressed: () => Navigator.pop(context),
        sliverContent: SliverFillRemaining(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];
              return RadioListTile(
                title: Text(option.label),
                value: index,
                groupValue: options.indexWhere((pOption) {
                  return pOption.key == selectedOptionKey;
                }),
                onChanged: (value) {
                  onSelected(options[value! as int].key);
                  Navigator.pop(context);
                },
                secondary:
                    (option.iconUrl.isEmpty) ? null : SvgPicture.asset(option.iconUrl, color: defaultTileIconColor, width: defaultTileIconSize),
                controlAffinity: ListTileControlAffinity.trailing,
              );
            },
          ),
        ),
      ),
    );
  }
}
