import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:kwriting/presentation/menu/menu.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/study/study.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:kwriting/presentation/words/words.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({required this.supportButton, Key? key}) : super(key: key);

  final ISupportButton supportButton;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (state is AppLoaded) {
          return state.isFirstTimeOpenApp
              ? Introduction(onFinished: () => context.read<AppCubit>().firstTimeOpenFinished())
              : Scaffold(
                  body: Stack(
                    children: [
                      const MenuBackground(),
                      MenuContent(supportButton: supportButton),
                    ],
                  ),
                );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class MenuContent extends StatelessWidget {
  const MenuContent({required this.supportButton, Key? key}) : super(key: key);

  final ISupportButton supportButton;

  double get menuExtraButtonIconSize => Device.get().isTablet ? 80.0 : 48.0;
  double get menuExtraButtonTitleSize => Device.get().isTablet ? 26.0 : 16.0;
  double get menuGridButtonsSpacing => Device.get().isTablet ? 32.0 : 16.0;
  EdgeInsets get menuPadding => Device.get().isTablet ? const EdgeInsets.symmetric(horizontal: 96) : const EdgeInsets.symmetric(horizontal: 24);

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
                        MenuButton(
                          title: strings.menuStudy,
                          iconUrl: IconUrl.study,
                          onPressed: () => Navigator.pushNamed(context, StudyPage.routeName),
                        ),
                        MenuButton(
                          title: strings.menuTraining,
                          iconUrl: IconUrl.training,
                          onPressed: () => Navigator.pushNamed(context, PreTrainingPage.routeName),
                        ),
                        MenuButton(
                          title: strings.menuWords,
                          iconUrl: IconUrl.words,
                          onPressed: () => Navigator.pushNamed(context, WordsPage.routeName),
                        ),
                        MenuButton(
                          title: strings.menuSettings,
                          iconUrl: IconUrl.settings,
                          onPressed: () => Navigator.pushNamed(context, SettingsPage.routeName),
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
                  ShareButton(iconSize: menuExtraButtonIconSize, titleSize: menuExtraButtonTitleSize, launcher: ShareLauncher()),
                  const SizedBox(width: 4),
                  supportButton,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({
    required this.title,
    required this.iconUrl,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final String title;
  final String iconUrl;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
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
