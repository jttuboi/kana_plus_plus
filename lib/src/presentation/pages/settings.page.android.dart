import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/data/datasources/banner_url.storage.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/controllers/settings.controller.dart';
import 'package:kana_plus_plus/src/presentation/state_management/quantity_of_words.provider.dart';
import 'package:kana_plus_plus/src/presentation/pages/description.page.android.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';
import 'package:kana_plus_plus/src/presentation/widgets/kana_type_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/language_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/quantity_of_words_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/show_hint_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/sub_header_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/writing_hand_tile.dart';
import 'package:kana_plus_plus/src/presentation/state_management/dark_theme.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/kana_type.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/language.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/show_hint.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/writing_hand.provider.dart';
import 'package:provider/provider.dart';

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
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                  final isCollapsed = constraints.biggest.height <= MediaQuery.of(context).padding.top + kToolbarHeight + 1;
                  return FlexibleSpaceBar(
                    centerTitle: true,
                    title: isCollapsed ? null : Text(strings.settingsTitle, style: appBarZoomTextStyle),
                    background: Container(color: Theme.of(context).primaryColor, child: SvgPicture.asset(BannerUrl.settings, fit: BoxFit.cover)),
                  );
                }),
                leading: IconButton(
                  icon: SvgPicture.asset(IconUrl.back, color: Theme.of(context).primaryIconTheme.color),
                  onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                ),
                expandedHeight: appBarExpandedHeight(context),
                pinned: true,
              ),
              SliverFillRemaining(
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
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DescriptionPage(
                            title: strings.settingsAbout,
                            descriptions: settingsController.aboutDescriptions,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(strings.settingsPrivacyPolicy),
                      leading: SvgPicture.asset(IconUrl.privacyPolicy, color: defaultTileIconColor, width: defaultTileIconSize),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DescriptionPage(
                            title: strings.settingsPrivacyPolicy,
                            descriptions: settingsController.privacyPolicyDescriptions,
                          ),
                        ),
                      ),
                    ),
                    // TODO https://developer.android.com/google/play/billing/index.html?authuser=3
                    ListTile(
                      title: Text(strings.settingsSupport),
                      leading: SvgPicture.asset(IconUrl.support, color: defaultTileIconColor, width: defaultTileIconSize),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
