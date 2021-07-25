import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/presentation/providers/locale.provider.dart';
import 'package:kana_plus_plus/src/presentation/pages/selection_option.page.android.dart';
import 'package:kana_plus_plus/src/presentation/providers/language.provider.dart';
import 'package:provider/provider.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({Key? key}) : super(key: key);

  void _updateLocalizationOnApp(BuildContext context, String localeCode) {
    Provider.of<LocaleProvider>(context, listen: false)
        .setLocale(JStrings.supportedLocales.firstWhere((Locale locale) {
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
          subtitle: Text(provider.text),
          leading: ImageIcon(AssetImage(provider.iconUrl)),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context2) => SelectionOptionPage(
                title: strings.settingsSelectLanguage,
                selectedOptionKey: provider.selectedKey,
                options: provider.options,
                onSelected: (selectedKey) {
                  final String key = selectedKey as String;
                  provider.updateKey(key);
                  _updateLocalizationOnApp(context, key);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
