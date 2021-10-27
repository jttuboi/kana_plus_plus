import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/menu/presentation/notifiers/theme.change_notifier.dart';
import 'package:kwriting/settings/presentation/notifiers/dark_theme.change_notifier.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
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
