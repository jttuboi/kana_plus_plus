import 'package:flutter/material.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/menu/menu.dart';
import 'package:kwriting/features/settings/settings.dart';
import 'package:provider/provider.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;

    return Consumer<LanguageChangeNotifier>(
      builder: (context, changeNotifier, child) {
        return DefaultTile(
          title: strings.settingsLanguage,
          subtitle: toLanguageText(changeNotifier.localeCode),
          iconUrl: IconUrl.language,
          onTap: () => Navigator.pushNamed(
            context,
            SelectionOptionPage.routeName,
            arguments: {
              SelectionOptionPage.argTitle: strings.settingsSelectLanguage,
              SelectionOptionPage.argBannerUrl: BannerUrl.language,
              SelectionOptionPage.argSelectedOptionKey: changeNotifier.localeCode,
              SelectionOptionPage.argOptions: _options,
              SelectionOptionPage.argOnSelected: (selectedKey) {
                changeNotifier.updateLanguage(selectedKey as String);
                context.read<LocaleChangeNotifier>().updateLocale();
              },
            },
          ),
        );
      },
    );
  }

  List<SelectionOptionItem> get _options {
    return JStrings.supportedLocales.map((locale) {
      return SelectionOptionItem(
        key: locale.languageCode,
        label: toLanguageText(locale.languageCode),
      );
    }).toList();
  }
}
