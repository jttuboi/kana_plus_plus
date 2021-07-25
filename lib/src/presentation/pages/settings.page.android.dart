import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/data/repositories/settings.repository.dart';
import 'package:kana_plus_plus/src/domain/settings.controller.dart';
import 'package:kana_plus_plus/src/presentation/blocs/settings.bloc.dart';
import 'package:kana_plus_plus/src/presentation/providers/quantity_of_words.provider.dart';
import 'package:kana_plus_plus/src/presentation/pages/description.page.dart';
import 'package:kana_plus_plus/src/presentation/widgets/dark_theme_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/kana_type_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/language_tile.dart';
import 'package:kana_plus_plus/src/views/android/widgets/quantity_of_words_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/show_hint_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/sub_header_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/writing_hand_tile.dart';
import 'package:kana_plus_plus/src/presentation/providers/dark_theme.provider.dart';
import 'package:kana_plus_plus/src/presentation/providers/kana_type.provider.dart';
import 'package:kana_plus_plus/src/presentation/providers/language.provider.dart';
import 'package:kana_plus_plus/src/presentation/providers/show_hint.provider.dart';
import 'package:kana_plus_plus/src/presentation/providers/writing_hand.provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _controller = SettingsController(SettingsRepository());
  late final SettingsBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SettingsBloc(_controller);
  }

  @override
  Widget build(BuildContext context) {
    final JStrings strings = JStrings.of(context)!;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(_controller),
        ),
        ChangeNotifierProvider(
          create: (context) => WritingHandProvider(_controller),
        ),
        ChangeNotifierProvider(
          create: (context) => DarkThemeProvider(_controller),
        ),
        ChangeNotifierProvider(
          create: (context) => ShowHintProvider(_controller),
        ),
        ChangeNotifierProvider(
          create: (context) => KanaTypeProvider(_controller),
        ),
        ChangeNotifierProvider(
          create: (context) => QuantityOfWordsProvider(_controller),
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
                leading: ImageIcon(AssetImage(_bloc.aboutIconUrl)),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DescriptionPage(
                      title: strings.settingsAbout,
                      descriptions: _bloc.aboutDescriptions,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(strings.settingsPrivacyPolicy),
                leading: ImageIcon(AssetImage(_bloc.privacyPolicyIconUrl)),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DescriptionPage(
                      title: strings.settingsPrivacyPolicy,
                      descriptions: _bloc.privacyPolicyDescriptions,
                    ),
                  ),
                ),
              ),
              // TODO https://developer.android.com/google/play/billing/index.html?authuser=3
              ListTile(
                title: Text(strings.settingsSupport),
                leading: ImageIcon(AssetImage(_bloc.supportIconUrl)),
              ),
            ],
          ),
        );
      },
    );
  }
}
