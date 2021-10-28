import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/menu/menu.dart';
import 'package:kwriting/settings/settings.dart';
import 'package:provider/provider.dart';

class DarkThemeTile extends StatelessWidget {
  const DarkThemeTile({Key? key}) : super(key: key);

  void _updateThemeOnApp(BuildContext context, bool isDarkTheme) {
    Provider.of<ThemeChangeNotifier>(context, listen: false).updateThemeMode(isDarkTheme);
  }

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return Consumer<DarkThemeChangeNotifier>(
      builder: (context, changeNotifier, child) {
        return SwitchListTile(
          title: Text(strings.settingsDarkTheme),
          value: changeNotifier.darkTheme,
          onChanged: (value) {
            changeNotifier.updateDarkTheme(value);
            _updateThemeOnApp(context, value);
          },
          secondary: SizedBox(
            height: double.infinity,
            child: SvgPicture.asset(changeNotifier.iconUrl, color: defaultTileIconColor, width: defaultTileIconSize),
          ),
        );
      },
    );
  }
}
