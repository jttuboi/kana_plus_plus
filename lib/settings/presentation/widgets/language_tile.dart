import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/menu/menu.dart';
import 'package:kwriting/settings/settings.dart';
import 'package:provider/provider.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return Consumer<LanguageProvider>(
      builder: (context, provider, child) {
        return ListTile(
          title: Text(strings.settingsLanguage),
          subtitle: Text(toLanguageText(provider.languageSelected)),
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
              SelectionOptionPage.argSelectedOptionKey: provider.languageSelected,
              SelectionOptionPage.argOptions: provider.options(toLanguageText),
              SelectionOptionPage.argOnSelected: (selectedKey) {
                provider.updateLanguageSelected(selectedKey as String);
                Provider.of<LocaleProvider>(context, listen: false).updateLocale();
              },
            },
          ),
        );
      },
    );
  }
}
