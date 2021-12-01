import 'package:flutter/material.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/menu/menu.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:provider/provider.dart';

class LanguageTile extends StatelessWidget {
  const LanguageTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    final state = context.watch<AppCubit>().state as AppLoaded;

    return DefaultTile(
      title: strings.settingsLanguage,
      subtitle: toLanguageText(state.languageCode),
      iconUrl: IconUrl.language,
      onTap: () => Navigator.pushNamed(
        context,
        SelectionOptionPage.routeName,
        arguments: {
          SelectionOptionPage.argSelectionOptionArgs: SelectionOptionArgs(
            title: strings.settingsSelectLanguage,
            bannerUrl: BannerUrl.language,
            selectedOptionKey: state.languageCode,
            options: _options,
            onSelected: (selectedKey) => context.read<AppCubit>().languageChanged(selectedKey as String),
          ),
        },
      ),
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
