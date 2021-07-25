import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/data/repositories/settings.repository.dart';
import 'package:kana_plus_plus/src/models/description.dart';
import 'package:kana_plus_plus/src/domain/settings.controller.dart';
import 'package:kana_plus_plus/src/views/android/pages/description.page.dart';
import 'package:kana_plus_plus/src/presentation/widgets/dark_theme_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/kana_type_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/language_tile.dart';
import 'package:kana_plus_plus/src/views/android/widgets/quantity_of_words_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/show_hint_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/sub_header_tile.dart';
import 'package:kana_plus_plus/src/shared/icons.dart';
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

  int _quantityOfWords = 5;

  final List<Description> _aboutDescriptions = [
    // AQUI localization
    // "settingsAbout1": "blablable",
    // "settingsAbout2": "informaçoes sobre mim",
    // "settingsAbout3": "contato",
    // "settingsAbout4": "de onde os dados vieram",
    Description.title("blablable"),
    Description.content("informaçoes sobre mim"),
    Description.content("contato"),
    Description.content("de onde os dados vieram"),
  ];

  final List<Description> _privacyPolicyDescriptions = [
    // AQUI localization
    // "settingsPrivacyPolicy1": "citar sobre uso",
    // "settingsPrivacyPolicy2": "blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla",
    Description.title("citar sobre uso"),
    Description.content(
        "blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla"),
  ];

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
              QuantityOfWordsTile(
                _quantityOfWords,
                onQuantityChanged: (quantity) => setState(() {
                  _quantityOfWords = quantity;
                }),
              ),
              const Divider(),
              SubHeaderTile(strings.settingsOthers),
              ListTile(
                title: Text(strings.settingsAbout),
                leading: JIcons.about,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DescriptionPage(
                      title: strings.settingsAbout,
                      descriptions: _aboutDescriptions,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(strings.settingsPrivacyPolicy),
                leading: JIcons.privacyPolicy,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DescriptionPage(
                      title: strings.settingsPrivacyPolicy,
                      descriptions: _privacyPolicyDescriptions,
                    ),
                  ),
                ),
              ),
              // TODO https://developer.android.com/google/play/billing/index.html?authuser=3
              ListTile(
                title: Text(strings.settingsSupport),
                leading: JIcons.support,
              ),
            ],
          ),
        );
      },
    );
  }
}
