import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kwriting/core/consts.dart';
import 'package:kwriting/menu/presentation/notifiers/locale.change_notifier.dart';
import 'package:kwriting/settings/presentation/notifiers/language.change_notifier.dart';
import 'package:kwriting/settings/presentation/views/selection_option.page.dart';
import 'package:kwriting/src/domain/utils/consts.dart';
import 'package:kwriting/src/infrastructure/datasources/banner_url.storage.dart';
import 'package:kwriting/src/infrastructure/datasources/icon_url.storage.dart';
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
                options: provider.options(toLanguageText),
                onSelected: (selectedKey) {
                  provider.updateLanguageSelected(selectedKey as String);
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
