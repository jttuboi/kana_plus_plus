import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    required this.showHintRepository,
    required this.kanaTypeRepository,
    required this.quantityOfWordsRepository,
    required this.urlLauncher,
    Key? key,
  }) : super(key: key);

  static const routeName = '/settings';

  static Route route() {
    return MaterialPageRoute(builder: (context) {
      return SettingsPage(
        showHintRepository: ShowHintRepository(HiveDatabase()),
        kanaTypeRepository: KanaTypeRepository(HiveDatabase()),
        quantityOfWordsRepository: QuantityOfWordsRepository(HiveDatabase()),
        urlLauncher: UrlLauncher(),
      );
    });
  }

  final IShowHintRepository showHintRepository;
  final IKanaTypeRepository kanaTypeRepository;
  final IQuantityOfWordsRepository quantityOfWordsRepository;
  final UrlLauncher urlLauncher;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ShowHintChangeNotifier(showHintRepository)),
        ChangeNotifierProvider(create: (context) => KanaTypeChangeNotifier(kanaTypeRepository)),
        ChangeNotifierProvider(create: (context) => QuantityOfWordsChangeNotifier(quantityOfWordsRepository)),
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
                const Divider(),
                SubHeaderTile(strings.settingsDefaultTrainingSetting),
                const ShowHintTile(),
                const KanaTypeTile(),
                const QuantityOfWordsTile(),
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
                  onTap: () => urlLauncher.openUrl(App.privacyPolicyUrl),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
