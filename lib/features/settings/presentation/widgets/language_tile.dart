import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        return ListTile(
          title: Text(strings.settingsLanguage),
          subtitle: Text(toLanguageText(changeNotifier.languageSelected)),
          leading: SizedBox(
            height: double.infinity,
            child: SvgPicture.asset(IconUrl.language, color: defaultTileIconColor, width: defaultTileIconSize),
          ),
          onTap: () => Navigator.pushNamed(
            context,
            SelectionOptionPage.routeName,
            arguments: {
              SelectionOptionPage.argTitle: strings.settingsSelectLanguage,
              SelectionOptionPage.argBannerUrl: BannerUrl.language,
              SelectionOptionPage.argSelectedOptionKey: changeNotifier.languageSelected,
              SelectionOptionPage.argOptions: changeNotifier.options(toLanguageText),
              SelectionOptionPage.argOnSelected: (selectedKey) {
                changeNotifier.updateLanguageSelected(selectedKey as String);
                Provider.of<LocaleChangeNotifier>(context, listen: false).updateLocale();
              },
            },
          ),
        );
      },
    );
  }
}
