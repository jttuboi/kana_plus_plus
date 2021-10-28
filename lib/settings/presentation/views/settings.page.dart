import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/settings/settings.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage._(this._settingsController, {Key? key}) : super(key: key);

  static const routeName = '/settings';
  static const argSettingsController = 'argSettingsController';

  static Route route(SettingsController settingsController) {
    return MaterialPageRoute(builder: (context) => SettingsPage._(settingsController));
  }

  final SettingsController _settingsController;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider(_settingsController)),
        ChangeNotifierProvider(create: (context) => WritingHandProvider(_settingsController)),
        ChangeNotifierProvider(create: (context) => DarkThemeProvider(_settingsController)),
        ChangeNotifierProvider(create: (context) => ShowHintProvider(_settingsController)),
        ChangeNotifierProvider(create: (context) => KanaTypeProvider(_settingsController)),
        ChangeNotifierProvider(create: (context) => QuantityOfWordsProvider(_settingsController)),
      ],
      builder: (context, child) {
        return FlexibleScaffold(
          title: strings.settingsTitle,
          bannerUrl: BannerUrl.settings,
          onBackButtonPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
          sliverContent: SliverFillRemaining(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                SubHeaderTile(strings.settingsBasic),
                const LanguageTile(),
                //const DarkThemeTile(),
                Consumer<WritingHandProvider>(
                  builder: (context, provider, child) {
                    return WritingHandTile(
                      writingHand: provider.writingHand,
                      iconUrl: provider.iconUrl,
                      options: provider.options,
                      updateWritingHand: provider.updateWritingHand,
                    );
                  },
                ),
                const Divider(),
                SubHeaderTile(strings.settingsDefaultTrainingSetting),
                Consumer<ShowHintProvider>(
                  builder: (context, provider, child) {
                    return ShowHintTile(
                      showHint: provider.showHint,
                      iconUrl: provider.iconUrl,
                      updateShowHint: provider.updateShowHint,
                    );
                  },
                ),
                Consumer<KanaTypeProvider>(
                  builder: (context, provider, child) {
                    return KanaTypeTile(
                      kanaType: provider.kanaType,
                      iconUrl: provider.iconUrl,
                      options: provider.options,
                      updateKanaType: provider.updateKanaType,
                    );
                  },
                ),
                Consumer<QuantityOfWordsProvider>(
                  builder: (context, provider, child) {
                    return QuantityOfWordsTile(
                      quantity: provider.quantity,
                      updateQuantity: provider.updateQuantity,
                    );
                  },
                ),
                const Divider(),
                SubHeaderTile(strings.settingsOthers),
                ListTile(
                  title: Text(strings.settingsAbout),
                  leading: SvgPicture.asset(IconUrl.about, color: defaultTileIconColor, width: defaultTileIconSize),
                  onTap: () => Navigator.pushNamed(context, AboutPage.routeName),
                ),
                ListTile(
                  title: Text(strings.settingsPrivacyPolicy),
                  leading: SvgPicture.asset(IconUrl.privacyPolicy, color: defaultTileIconColor, width: defaultTileIconSize),
                  onTap: () async {
                    if (await canLaunch(App.privacyPolicyUrl)) {
                      await launch(App.privacyPolicyUrl);
                    } else {
                      // do nothing
                      Logger().e('Could not launch ${App.privacyPolicyUrl}');
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
