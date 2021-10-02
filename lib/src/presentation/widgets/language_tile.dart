import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kana_plus_plus/src/data/datasources/banner_url.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/utils/consts.dart';
import 'package:kana_plus_plus/src/presentation/pages/selection_option.page.android.dart';
import 'package:kana_plus_plus/src/presentation/state_management/language.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/locale.provider.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';
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
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context2) => SelectionOptionPage(
                title: strings.settingsSelectLanguage,
                bannerUrl: BannerUrl.language,
                selectedOptionKey: provider.languageSelected,
                options: provider.options((localeCode) {
                  return toLanguageText(localeCode);
                }),
                onSelected: (selectedKey) {
                  final String key = selectedKey as String;
                  provider.updateLanguageSelected(key);
                  Provider.of<LocaleProvider>(context, listen: false).updateLocale();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
