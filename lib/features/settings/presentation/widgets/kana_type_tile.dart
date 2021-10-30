import 'package:flutter/material.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';
import 'package:provider/provider.dart';

class KanaTypeTile extends StatelessWidget {
  const KanaTypeTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;

    return Consumer<KanaTypeChangeNotifier>(
      builder: (context, changeNotifier, child) {
        return DefaultTile(
          title: strings.settingsKanaType,
          subtitle: _getText(context, changeNotifier.data.kanaType),
          iconUrl: changeNotifier.data.iconUrl,
          onTap: () => Navigator.pushNamed(
            context,
            SelectionOptionPage.routeName,
            arguments: {
              SelectionOptionPage.argSelectionOptionArgs: SelectionOptionArgs(
                title: strings.settingsSelectKanaType,
                bannerUrl: BannerUrl.kanaType,
                selectedOptionKey: changeNotifier.data.kanaType,
                options: _options(context, changeNotifier.kanaTypesData),
                onSelected: (selectedKey) => changeNotifier.updateKanaType(selectedKey as KanaType),
              ),
            },
          ),
        );
      },
    );
  }

  List<SelectionOptionItem> _options(BuildContext context, List<KanaTypeData> kanaTypesData) {
    return kanaTypesData.map((data) {
      return SelectionOptionItem(
        key: data.kanaType,
        label: _getText(context, data.kanaType),
        iconUrl: data.iconUrl,
      );
    }).toList();
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
