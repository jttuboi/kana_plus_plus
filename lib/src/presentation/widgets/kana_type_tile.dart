import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/presentation/arguments/selection_option.arguments.dart';
import 'package:kana_plus_plus/src/presentation/pages/selection_option.page.android.dart';

class KanaTypeTile extends StatelessWidget {
  const KanaTypeTile({
    Key? key,
    required this.kanaType,
    required this.iconUrl,
    required this.getOptions,
    required this.updateKanaType,
  }) : super(key: key);

  final KanaType kanaType;
  final String iconUrl;
  final List<SelectionOptionArguments> Function(
      String Function(KanaType kanaType) kanaTypeText) getOptions;
  final Function(KanaType kanaType) updateKanaType;

  @override
  Widget build(BuildContext context) {
    final JStrings strings = JStrings.of(context)!;
    return ListTile(
      title: Text(strings.settingsKanaType),
      subtitle: Text(_getText(context, kanaType)),
      leading: ImageIcon(AssetImage(iconUrl)),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context2) => SelectionOptionPage(
              title: strings.settingsSelectKanaType,
              selectedOptionKey: kanaType,
              options: getOptions((kanaType2) {
                return _getText(context, kanaType2);
              }),
              onSelected: (selectedKey) {
                updateKanaType(selectedKey as KanaType);
              }),
        ),
      ),
    );
  }

  String _getText(BuildContext context, KanaType type) {
    final JStrings strings = JStrings.of(context)!;
    if (type.isOnlyHiragana) return strings.settingsOnlyHiragana;
    if (type.isOnlyKatakana) return strings.settingsOnlyKatakana;
    if (type.isBoth) return strings.settingsOnlyHiraganaKatakana;
    return "";
  }
}
