import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/providers/dark_theme.provider.dart';
import 'package:kana_plus_plus/src/providers/locale_provider.dart';
import 'package:kana_plus_plus/src/providers/show_hint.provider.dart';
import 'package:kana_plus_plus/src/models/description.dart';
import 'package:kana_plus_plus/src/controllers/settings.controller.dart';
import 'package:kana_plus_plus/src/providers/theme_provider.dart';
import 'package:kana_plus_plus/src/repositories/settings.repository.dart';
import 'package:kana_plus_plus/src/views/android/pages/description.page.dart';
import 'package:kana_plus_plus/src/views/android/pages/selection_option.page.dart';
import 'package:kana_plus_plus/src/views/android/widgets/kana_type_tile.dart';
import 'package:kana_plus_plus/src/views/android/widgets/quantity_of_words_tile.dart';
import 'package:kana_plus_plus/src/views/android/widgets/sub_header_tile.dart';
import 'package:kana_plus_plus/src/models/selection_option.dart';
import 'package:kana_plus_plus/src/shared/icons.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _controller = SettingsController(SettingsRepository());

  int _languageSelectedIdx = 0; // english
  final List<SelectionOption> _languageOptions = [
    // AQUI localization
    const SelectionOption("English"),
    const SelectionOption("Português"),
    const SelectionOption("Spañol"),
  ];

  int _writingHandSelectedIdx = 1; // right hand
  final List<SelectionOption> _writingHandOptions = [
    // AQUI localization
    const SelectionOption("Left hand", icon: JIcons.writingHandLeft),
    const SelectionOption("Right hand", icon: JIcons.writingHandRight),
  ];

  bool _darkMode = false; // padrao do celular
  int _kanaSelectedIdx = 2; // both

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

  void _updateLocaleOnApp(BuildContext context, String localeCode) {
    final provider = Provider.of<LocaleProvider>(context, listen: false);
    provider.setLocale(JStrings.supportedLocales.firstWhere((Locale locale) {
      return locale.toString() == localeCode;
    }));
  }

  void _updateDarkTheme(BuildContext context, bool value) {
    final provider = Provider.of<DarkThemeProvider>(context, listen: false);
    provider.changeDarkTheme(value);

    final provider2 = Provider.of<ThemeProvider>(context, listen: false);
    provider2.updateThemeMode(provider.isDarkTheme);
  }

  void _updateShowHint(BuildContext context, bool value) {
    final provider = Provider.of<ShowHintProvider>(context, listen: false);
    provider.changeShowHint(value);
  }

  @override
  Widget build(BuildContext context) {
    final JStrings strings = JStrings.of(context)!;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ShowHintProvider(_controller),
        ),
        ChangeNotifierProvider(
          create: (context) => DarkThemeProvider(_controller),
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
          ListTile(
            title: Text(strings.settingsLanguage),
            // TODO  ver como escrever "(default)" na frente da palavra
            subtitle: Text(_languageOptions[_languageSelectedIdx].title),
            leading: JIcons.language,
            onTap: () async {
              final selectedIdx = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectionOptionPage(
                    title: strings.settingsSelectLanguage,
                    optionSelectedIndex: _languageSelectedIdx,
                    options: _languageOptions,
                  ),
                ),
              );
              setState(() {
                _languageSelectedIdx = selectedIdx as int;
                if (_languageSelectedIdx == 0) {
                  _updateLocaleOnApp(context, "en");
                } else if (_languageSelectedIdx == 1) {
                  _updateLocaleOnApp(context, "pt_BR");
                } else if (_languageSelectedIdx == 2) {
                  _updateLocaleOnApp(context, "es");
                }
              });
            },
          ),
              Consumer<DarkThemeProvider>(
            builder: (context, value, child) {
              return SwitchListTile(
                title: Text(strings.settingsDarkTheme),
                    value: value.isDarkTheme,
                    onChanged: (value) => _updateDarkTheme(context, value),
                    secondary: ImageIcon(AssetImage(value.darkThemeIconUrl)),
              );
            },
          ),
          const Divider(),
          SubHeaderTile(strings.settingsDefaultTrainingSetting),
          Consumer<ShowHintProvider>(
            builder: (context, value, child) {
              return SwitchListTile(
                title: Text(strings.settingsShowHint),
                    value: value.isShowHint,
                    onChanged: (value) => _updateShowHint(context, value),
                secondary: ImageIcon(AssetImage(value.showHintIconUrl)),
              );
            },
          ),
          KanaTypeTile(
            _kanaSelectedIdx,
            onOptionSelected: (index) => setState(() {
              _kanaSelectedIdx = index;
            }),
          ),
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
