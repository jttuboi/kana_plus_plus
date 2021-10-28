import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';
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
        ChangeNotifierProvider(create: (context) => LanguageChangeNotifier(_settingsController)),
        ChangeNotifierProvider(create: (context) => WritingHandChangeNotifier(_settingsController)),
        ChangeNotifierProvider(create: (context) => ShowHintChangeNotifier(_settingsController)),
        ChangeNotifierProvider(create: (context) => KanaTypeChangeNotifier(_settingsController)),
        ChangeNotifierProvider(create: (context) => QuantityOfWordsChangeNotifier(_settingsController)),
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
                Consumer<WritingHandChangeNotifier>(
                  builder: (context, changeNotifier, child) {
                    return WritingHandTile(
                      writingHand: changeNotifier.writingHand,
                      iconUrl: changeNotifier.iconUrl,
                      options: changeNotifier.options,
                      updateWritingHand: changeNotifier.updateWritingHand,
                    );
                  },
                ),
                const Divider(),
                SubHeaderTile(strings.settingsDefaultTrainingSetting),
                Consumer<ShowHintChangeNotifier>(
                  builder: (context, changeNotifier, child) {
                    return ShowHintTile(
                      showHint: changeNotifier.showHint,
                      iconUrl: changeNotifier.iconUrl,
                      updateShowHint: changeNotifier.updateShowHint,
                    );
                  },
                ),
                Consumer<KanaTypeChangeNotifier>(
                  builder: (context, changeNotifier, child) {
                    return KanaTypeTile(
                      kanaType: changeNotifier.kanaType,
                      iconUrl: changeNotifier.iconUrl,
                      options: changeNotifier.options,
                      updateKanaType: changeNotifier.updateKanaType,
                    );
                  },
                ),
                Consumer<QuantityOfWordsChangeNotifier>(
                  builder: (context, changeNotifier, child) {
                    return QuantityOfWordsTile(
                      quantity: changeNotifier.quantity,
                      updateQuantity: changeNotifier.updateQuantity,
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
