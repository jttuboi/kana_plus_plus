import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';
import 'package:kana_plus_plus/src/presentation/arguments/selection_option.arguments.dart';
import 'package:kana_plus_plus/src/presentation/pages/selection_option.page.android.dart';

class WritingHandTile extends StatelessWidget {
  const WritingHandTile({
    Key? key,
    required this.writingHand,
    required this.iconUrl,
    required this.getOptions,
    required this.updateWritingHand,
  }) : super(key: key);

  final WritingHand writingHand;
  final String iconUrl;
  final List<SelectionOptionArguments> Function(
      String Function(WritingHand writingHand) writingHandText) getOptions;
  final Function(WritingHand writingHand) updateWritingHand;

  @override
  Widget build(BuildContext context) {
    final JStrings strings = JStrings.of(context)!;
    return ListTile(
      title: Text(strings.settingsWritingHand),
      subtitle: Text(_getText(context, writingHand)),
      leading: ImageIcon(AssetImage(iconUrl)),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context2) => SelectionOptionPage(
            title: strings.settingsSelectWritingHand,
            selectedOptionKey: writingHand,
            options: getOptions((writingHand2) {
              return _getText(context, writingHand2);
            }),
            onSelected: (selectedKey) {
              updateWritingHand(selectedKey as WritingHand);
            },
          ),
        ),
      ),
    );
  }

  String _getText(BuildContext context, WritingHand key) {
    final JStrings strings = JStrings.of(context)!;
    if (key.isLeft) return strings.settingsWritingHandLeft;
    if (key.isRight) return strings.settingsWritingHandRight;
    return "";
  }
}
