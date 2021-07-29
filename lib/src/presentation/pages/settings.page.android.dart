import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/data/repositories/settings.repository.dart';
import 'package:kana_plus_plus/src/presentation/state_management/settings.bloc.dart';
import 'package:kana_plus_plus/src/presentation/state_management/quantity_of_words.provider.dart';
import 'package:kana_plus_plus/src/presentation/pages/description.page.android.dart';
import 'package:kana_plus_plus/src/presentation/widgets/dark_theme_tile.dart';
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

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _repository = SettingsRepository();
  late final SettingsStateManagement _stateManagement;

  @override
  void initState() {
    super.initState();
    _stateManagement = SettingsStateManagement(_repository);
  }

  @override
  Widget build(BuildContext context) {
    final JStrings strings = JStrings.of(context)!;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(_repository),
        ),
        ChangeNotifierProvider(
          create: (context) => WritingHandProvider(_repository),
        ),
        ChangeNotifierProvider(
          create: (context) => DarkThemeProvider(_repository),
        ),
        ChangeNotifierProvider(
          create: (context) => ShowHintProvider(_repository),
        ),
        ChangeNotifierProvider(
          create: (context) => KanaTypeProvider(_repository),
        ),
        ChangeNotifierProvider(
          create: (context) => QuantityOfWordsProvider(_repository),
        ),
      ],
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(strings.settingsTitle),
          ),
          body: ListView(
            children: [
              SubHeaderTile(strings.settingsBasic),
              const LanguageTile(),
              const DarkThemeTile(),
              const WritingHandTile(),
              const Divider(),
              SubHeaderTile(strings.settingsDefaultTrainingSetting),
              const ShowHintTile(),
              const KanaTypeTile(),
              const QuantityOfWordsTile(),
              const Divider(),
              SubHeaderTile(strings.settingsOthers),
              ListTile(
                title: Text(strings.settingsAbout),
                leading: ImageIcon(AssetImage(_stateManagement.aboutIconUrl)),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DescriptionPage(
                      title: strings.settingsAbout,
                      descriptions: _stateManagement.aboutDescriptions,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(strings.settingsPrivacyPolicy),
                leading: ImageIcon(
                    AssetImage(_stateManagement.privacyPolicyIconUrl)),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DescriptionPage(
                      title: strings.settingsPrivacyPolicy,
                      descriptions: _stateManagement.privacyPolicyDescriptions,
                    ),
                  ),
                ),
              ),
              // TODO https://developer.android.com/google/play/billing/index.html?authuser=3
              ListTile(
                title: Text(strings.settingsSupport),
                leading: ImageIcon(AssetImage(_stateManagement.supportIconUrl)),
              ),
            ],
          ),
        );
      },
    );
  }
}
