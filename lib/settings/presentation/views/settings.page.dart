import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/consts.dart';
import 'package:kwriting/menu/presentation/widgets/flexible_scaffold.dart';
import 'package:kwriting/settings/domain/use_cases/settings.controller.dart';
import 'package:kwriting/settings/presentation/notifiers/dark_theme.change_notifier.dart';
import 'package:kwriting/settings/presentation/notifiers/kana_type.change_notifier.dart';
import 'package:kwriting/settings/presentation/notifiers/language.change_notifier.dart';
import 'package:kwriting/settings/presentation/notifiers/quantity_of_words.change_notifier.dart';
import 'package:kwriting/settings/presentation/notifiers/show_hint.change_notifier.dart';
import 'package:kwriting/settings/presentation/notifiers/writing_hand.change_notifier.dart';
import 'package:kwriting/settings/presentation/widgets/kana_type_tile.dart';
import 'package:kwriting/settings/presentation/widgets/language_tile.dart';
import 'package:kwriting/settings/presentation/widgets/quantity_of_words_tile.dart';
import 'package:kwriting/settings/presentation/widgets/show_hint_tile.dart';
import 'package:kwriting/settings/presentation/widgets/sub_header_tile.dart';
import 'package:kwriting/settings/presentation/widgets/writing_hand_tile.dart';
import 'package:kwriting/src/domain/utils/consts.dart';
import 'package:kwriting/src/infrastructure/datasources/banner_url.storage.dart';
import 'package:kwriting/src/infrastructure/datasources/icon_url.storage.dart';
import 'package:kwriting/src/presentation/utils/routes.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage(this.settingsController, {Key? key}) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LanguageProvider(settingsController)),
        ChangeNotifierProvider(create: (context) => WritingHandProvider(settingsController)),
        ChangeNotifierProvider(create: (context) => DarkThemeProvider(settingsController)),
        ChangeNotifierProvider(create: (context) => ShowHintProvider(settingsController)),
        ChangeNotifierProvider(create: (context) => KanaTypeProvider(settingsController)),
        ChangeNotifierProvider(create: (context) => QuantityOfWordsProvider(settingsController)),
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
                  onTap: () => Navigator.pushNamed(context, Routes.about),
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
