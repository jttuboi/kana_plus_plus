import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/controllers/app.controller.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';
import 'package:kana_plus_plus/src/presentation/widgets/introduction.dart';
import 'package:kana_plus_plus/src/presentation/widgets/menu_background.dart';
import 'package:kana_plus_plus/src/presentation/widgets/share_button.dart';
import 'package:kana_plus_plus/src/presentation/widgets/support_button.dart';

class MenuPage extends StatefulWidget {
  const MenuPage(this.appController, {Key? key}) : super(key: key);

  final AppController appController;

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return (widget.appController.isFirstTime)
        ? Introduction(onFinished: () => setState(() => widget.appController.finishFirstTime()))
        : Scaffold(
            body: Stack(
              children: [
                const MenuBackground(),
                _MenuExtra(widget.appController),
                const _MenuContent(),
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
                child: Text(App.title.toUpperCase(), textAlign: TextAlign.center, style: menuTitleTextStyle),
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

class _MenuExtra extends StatelessWidget {
  const _MenuExtra(this.appController, {Key? key}) : super(key: key);

  final AppController appController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.bottomRight,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          ShareButton(iconSize: 48),
          SizedBox(width: 4.0),
          SupportButton(iconSize: 48),
        ],
      ),
    );
  }
}
