import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class KanaTypeTile extends StatelessWidget {
  const KanaTypeTile({
    required this.kanaType,
    required this.iconUrl,
    required this.options,
    required this.updateKanaType,
    Key? key,
  }) : super(key: key);

  final KanaType kanaType;
  final String iconUrl;
  final List<SelectionOptionItem> Function(String Function(KanaType kanaType) kanaTypeText) options;
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
      onTap: () => Navigator.pushNamed(
        context,
        SelectionOptionPage.routeName,
        arguments: {
          SelectionOptionPage.argTitle: strings.settingsSelectKanaType,
          SelectionOptionPage.argBannerUrl: BannerUrl.kanaType,
          SelectionOptionPage.argSelectedOptionKey: kanaType,
          SelectionOptionPage.argOptions: options((pKanaType) {
            return _getText(context, pKanaType);
          }),
          SelectionOptionPage.argOnSelected: (selectedKey) {
            updateKanaType(selectedKey as KanaType);
          },
        },
      ),
    );
  }

  String _getText(BuildContext context, KanaType type) {
    final strings = JStrings.of(context)!;
    if (type.isOnlyHiragana) {
      return strings.settingsOnlyHiragana;
    }
    if (type.isOnlyKatakana) {
      return strings.settingsOnlyKatakana;
    }
    if (type.isBoth) {
      return strings.settingsOnlyHiraganaKatakana;
    }
    return '';
  }
}
