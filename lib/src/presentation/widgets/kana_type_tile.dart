import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/domain/core/kana_type.dart';
import 'package:kana_plus_plus/src/presentation/arguments/selection_option.arguments.dart';
import 'package:kana_plus_plus/src/presentation/pages/selection_option.page.android.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';

class KanaTypeTile extends StatelessWidget {
  const KanaTypeTile({
    Key? key,
    required this.kanaType,
    required this.iconUrl,
    required this.options,
    required this.updateKanaType,
  }) : super(key: key);

  final KanaType kanaType;
  final String iconUrl;
  final List<SelectionOptionArguments> Function(String Function(KanaType kanaType) kanaTypeText) options;
  final Function(KanaType kanaType) updateKanaType;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return ListTile(
      title: Text(strings.settingsKanaType),
      subtitle: Text(_getText(context, kanaType)),
      leading: SizedBox(
        height: double.infinity,
        child: SvgPicture.asset(iconUrl, color: defaultTileIconColor, width: defaultTileIconSize),
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context2) => SelectionOptionPage(
              title: strings.settingsSelectKanaType,
              selectedOptionKey: kanaType,
              options: options((pKanaType) {
                return _getText(context, pKanaType);
              }),
              onSelected: (selectedKey) {
                updateKanaType(selectedKey as KanaType);
              }),
        ),
      ),
    );
  }

  String _getText(BuildContext context, KanaType type) {
    final strings = JStrings.of(context)!;
    if (type.isOnlyHiragana) return strings.settingsOnlyHiragana;
    if (type.isOnlyKatakana) return strings.settingsOnlyKatakana;
    if (type.isBoth) return strings.settingsOnlyHiraganaKatakana;
    return '';
  }
}
