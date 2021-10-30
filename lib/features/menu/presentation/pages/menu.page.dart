import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/menu/menu.dart';
import 'package:kwriting/features/settings/settings.dart';
import 'package:kwriting/features/study/study.dart';
import 'package:kwriting/features/training/training.dart';
import 'package:kwriting/features/words/words.dart';

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
                _MenuContent(),
              ],
            ),
          );
  }
}

class _MenuContent extends StatelessWidget {
  _MenuContent({Key? key}) : super(key: key);

  final menuExtraButtonIconSize = Device.get().isTablet ? 80.0 : 48.0;
  final menuExtraButtonTitleSize = Device.get().isTablet ? 26.0 : 16.0;
  final menuGridButtonsSpacing = Device.get().isTablet ? 32.0 : 16.0;
  final menuPadding = Device.get().isTablet ? const EdgeInsets.symmetric(horizontal: 96) : const EdgeInsets.symmetric(horizontal: 24);

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return SafeArea(
      child: Column(
        children: [
          Flexible(
            flex: Device.get().isTablet ? 2 : 3,
            child: Container(
              alignment: Alignment.center,
              padding: menuPadding,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  App.title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Device.get().isTablet ? 160 : 100,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Permanent Marker',
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: Device.get().isTablet ? 4 : 6,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Padding(
                  padding: menuPadding,
                  child: SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxHeight,
                    child: GridView.count(
                      mainAxisSpacing: menuGridButtonsSpacing,
                      crossAxisSpacing: menuGridButtonsSpacing,
                      crossAxisCount: 2,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _MenuButton(
                          title: strings.menuStudy,
                          iconUrl: IconUrl.study,
                          routeName: StudyPage.routeName,
                        ),
                        _MenuButton(
                          title: strings.menuTraining,
                          iconUrl: IconUrl.training,
                          routeName: PreTrainingPage.routeName,
                          arguments: {
                            PreTrainingPage.argPreTrainingController: PreTrainingController(
                              showHintRepository: ShowHintRepository(),
                              kanaTypeRepository: KanaTypeRepository(),
                              quantityOfWordsRepository: QuantityOfWordsRepository(),
                            ),
                          },
                        ),
                        _MenuButton(
                          title: strings.menuWords,
                          iconUrl: IconUrl.words,
                          routeName: WordsPage.routeName,
                          arguments: {
                            WordsPage.argWordsController: WordsController(
                              wordRepository: WordRepository(),
                            ),
                          },
                        ),
                        _MenuButton(
                          title: strings.menuSettings,
                          iconUrl: IconUrl.settings,
                          routeName: SettingsPage.routeName,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Flexible(
            flex: Device.get().isTablet ? 1 : 2,
            child: Container(
              alignment: FractionalOffset.bottomRight,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShareButton(iconSize: menuExtraButtonIconSize, titleSize: menuExtraButtonTitleSize),
                  const SizedBox(width: 4),
                  SupportButton(iconSize: menuExtraButtonIconSize, titleSize: menuExtraButtonTitleSize),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({
    required this.title,
    required this.iconUrl,
    required this.routeName,
    this.arguments,
    Key? key,
  }) : super(key: key);

  final String title;
  final String iconUrl;
  final String routeName;
  final Object? arguments;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, routeName, arguments: arguments);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconUrl,
            width: Device.get().isTablet ? 140.0 : 70.0,
            height: Device.get().isTablet ? 140.0 : 70.0,
            color: Colors.grey.shade200,
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade200,
                fontSize: Device.get().isTablet ? 50 : 28,
                fontFamily: 'Permanent Marker',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
