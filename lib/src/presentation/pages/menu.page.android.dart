import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/src/data/datasources/icon_url.storage.dart';
import 'package:kwriting/src/domain/controllers/app.controller.dart';
import 'package:kwriting/src/domain/utils/consts.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:kwriting/src/presentation/utils/routes.dart';
import 'package:kwriting/src/presentation/widgets/introduction.dart';
import 'package:kwriting/src/presentation/widgets/menu_background.dart';
import 'package:kwriting/src/presentation/widgets/share_button.dart';
import 'package:kwriting/src/presentation/widgets/support_button.dart';

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
            flex: Device.get().isTablet ? 1 : 3,
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
            flex: Device.get().isTablet ? 3 : 7,
            child: GridView.count(
              mainAxisSpacing: menuGridButtonsSpacing,
              crossAxisSpacing: menuGridButtonsSpacing,
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: menuGridButtonsPadding,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, Routes.study),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(IconUrl.study, width: menuButtonIconSize, height: menuButtonIconSize, color: menuButtonIconColor),
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
                      SvgPicture.asset(IconUrl.training, width: menuButtonIconSize, height: menuButtonIconSize, color: menuButtonIconColor),
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
                      SvgPicture.asset(IconUrl.words, width: menuButtonIconSize, height: menuButtonIconSize, color: menuButtonIconColor),
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
                      SvgPicture.asset(IconUrl.settings, width: menuButtonIconSize, height: menuButtonIconSize, color: menuButtonIconColor),
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
        children: [
          ShareButton(iconSize: menuExtraButtonIconSize),
          const SizedBox(width: 4.0),
          SupportButton(iconSize: menuExtraButtonIconSize),
        ],
      ),
    );
  }
}
