import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';
import 'package:kana_plus_plus/src/presentation/widgets/menu_background.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          MenuBackground(),
          _MenuContent(),
        ],
      ),
    );
  }
}

class _MenuContent extends StatelessWidget {
  const _MenuContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return SafeArea(
      child: Column(
        children: [
          Flexible(
            flex: 3,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(appTitle.toUpperCase(), textAlign: TextAlign.center, style: menuTitleTextStyle),
              ),
            ),
          ),
          Flexible(
            flex: 7,
            child: GridView.count(
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, Routes.study),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(IconUrl.study, width: 80, height: 80, color: menuButtonIconColor),
                      const SizedBox(height: 4.0),
                      FittedBox(fit: BoxFit.fitWidth, child: Text(strings.menuStudy, style: menuButtonTextStyle)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, Routes.preTraining),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(IconUrl.training, width: 80, height: 80, color: menuButtonIconColor),
                      const SizedBox(height: 4.0),
                      FittedBox(fit: BoxFit.fitWidth, child: Text(strings.menuTraining, style: menuButtonTextStyle)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, Routes.words),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(IconUrl.words, width: 80, height: 80, color: menuButtonIconColor),
                      const SizedBox(height: 4.0),
                      FittedBox(fit: BoxFit.fitWidth, child: Text(strings.menuWords, style: menuButtonTextStyle)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, Routes.settings),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(IconUrl.settings, width: 80, height: 80, color: menuButtonIconColor),
                      const SizedBox(height: 4.0),
                      FittedBox(fit: BoxFit.fitWidth, child: Text(strings.menuSettings, style: menuButtonTextStyle)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
