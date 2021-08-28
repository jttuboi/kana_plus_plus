import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:kana_plus_plus/src/presentation/state_management/locale.provider.dart';
import 'package:kana_plus_plus/src/presentation/pages/selection_option.page.android.dart';
import 'package:kana_plus_plus/src/presentation/state_management/language.provider.dart';
import 'package:provider/provider.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({Key? key}) : super(key: key);

  void _updateLocalizationOnApp(BuildContext context, String localeCode) {
    Provider.of<LocaleProvider>(context, listen: false).setLocale(JStrings.supportedLocales.firstWhere((Locale locale) {
      return locale.toString() == localeCode;
    }));
  }

  @override
  Widget build(BuildContext context) {
    final JStrings strings = JStrings.of(context)!;
    return Consumer<LanguageProvider>(
      builder: (context, provider, child) {
        return ListTile(
          title: Text(strings.settingsLanguage),
          subtitle: Text(_getText(provider.languageSelected)),
          leading: ImageIcon(AssetImage(provider.iconUrl)),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context2) => SelectionOptionPage(
                title: strings.settingsSelectLanguage,
                selectedOptionKey: provider.languageSelected,
                options: provider.getOptions((localeCode) {
                  return _getText(localeCode);
                }),
                onSelected: (selectedKey) {
                  final String key = selectedKey as String;
                  provider.updateLanguageSelected(key);
                  _updateLocalizationOnApp(context, key);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  String _getText(String localeCode) {
    return LocaleNamesLocalizationsDelegate.nativeLocaleNames[localeCode] ?? 'English';
  }
}
