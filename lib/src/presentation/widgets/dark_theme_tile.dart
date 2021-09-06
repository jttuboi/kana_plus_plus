import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/presentation/state_management/dark_theme.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/theme.provider.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';
import 'package:provider/provider.dart';

class DarkThemeTile extends StatelessWidget {
  const DarkThemeTile({Key? key}) : super(key: key);

  void _updateThemeOnApp(BuildContext context, bool isDarkTheme) {
    Provider.of<ThemeProvider>(context, listen: false).updateThemeMode(isDarkTheme);
  }

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return Consumer<DarkThemeProvider>(
      builder: (context, provider, child) {
        return SwitchListTile(
          title: Text(strings.settingsDarkTheme),
          value: provider.darkTheme,
          onChanged: (value) {
            provider.updateDarkTheme(value);
            _updateThemeOnApp(context, value);
          },
          secondary: SizedBox(
            height: double.infinity,
            child: SvgPicture.asset(provider.iconUrl, color: defaultTileIconColor, width: defaultTileIconSize),
          ),
        );
      },
    );
  }
}
