import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/settings/description.dart';
import 'package:kana_plus_plus/src/settings/description_page.dart';
import 'package:kana_plus_plus/src/settings/kana_type_tile.dart';
import 'package:kana_plus_plus/src/settings/quantity_of_cards_tile.dart';
import 'package:kana_plus_plus/src/settings/selection_option.dart';
import 'package:kana_plus_plus/src/settings/selection_option_page.dart';
import 'package:kana_plus_plus/src/settings/show_hint_tile.dart';
import 'package:kana_plus_plus/src/settings/sub_header_tile.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _languageSelectedIdx = 0; // english
  final List<SelectionOption> _languageOptions = [
    // AQUI localization
    const SelectionOption("English"),
    const SelectionOption("Português"),
    const SelectionOption("Spañol"),
  ];

  int _writingHandSelectedIdx = 1; // right hand
  final List<SelectionOption> _writingHandOptions = [
    // AQUI localization icon
    const SelectionOption("Left hand", icon: Icon(Icons.swipe)),
    const SelectionOption("Right hand", icon: Icon(Icons.pan_tool)),
  ];

  bool _darkMode = false; // padrao do celular
  bool _showHint = false; // not selected
  int _kanaSelectedIdx = 2; // both

  int _quantityOfCards = 5;

  final List<Description> _aboutDescriptions = [
    // AQUI localization
    Description.title("blablable"),
    Description.content("informaçoes sobre mim"),
    Description.content("contato"),
    Description.content("de onde os dados vieram"),
  ];

  final List<Description> _privacyPolicyDescriptions = [
    // AQUI localization
    Description.title("citar sobre uso"),
    Description.content(
        "blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"), // AQUI localization
      ),
      body: ListView(
        children: [
          const SubHeaderTile("Basic"), // AQUI localization
          ListTile(
            title: const Text("Language"), // AQUI localization
            // TODO  ver como escrever "(default)" na frente da palavra
            subtitle: Text(_languageOptions[_languageSelectedIdx].title),
            leading: const Icon(Icons.translate), // AQUI icon
            onTap: () async {
              final selectedIdx = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectionOptionPage(
                    title: "Select language", // AQUI localization
                    optionSelectedIndex: _languageSelectedIdx,
                    options: _languageOptions,
                  ),
                ),
              );
              setState(() {
                _languageSelectedIdx = selectedIdx as int;
              });
            },
          ),
          ListTile(
            title: const Text("Writing hand"), // AQUI localization
            subtitle: Text(_writingHandOptions[_writingHandSelectedIdx].title),
            leading:
                _writingHandOptions[_writingHandSelectedIdx].icon, // AQUI icon
            onTap: () async {
              final selectedIdx = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectionOptionPage(
                    title: "Select writing hand", // AQUI localization
                    optionSelectedIndex: _writingHandSelectedIdx,
                    options: _writingHandOptions,
                  ),
                ),
              );
              setState(() {
                _writingHandSelectedIdx = selectedIdx as int;
              });
            },
          ),
          SwitchListTile(
            //  TODO setar default do sistema ao entrar (ver como escrever "(default)" na frente da palavra)
            title: const Text("Dark mode"), // AQUI localization
            value: _darkMode,
            onChanged: (value) => setState(() {
              _darkMode = value;
            }),
            secondary: _darkMode
                ? const Icon(Icons.dark_mode) // AQUI icon
                : const Icon(Icons.light_mode), // AQUI icon
          ),
          const Divider(),
          const SubHeaderTile("Default training setting"), // AQUI localization
          ShowHintTile(
            _showHint,
            onChanged: (value) => setState(() {
              _showHint = value;
            }),
          ),
          KanaTypeTile(
            _kanaSelectedIdx,
            onOptionSelected: (index) => setState(() {
              _kanaSelectedIdx = index;
            }),
          ),
          QuantityOfCardsTile(
            _quantityOfCards,
            onQuantityChanged: (quantity) => setState(() {
              _quantityOfCards = quantity;
            }),
          ),
          const Divider(),
          const SubHeaderTile("Others"), // AQUI localization
          ListTile(
            title: const Text("About"), // AQUI localization
            leading: const Icon(Icons.info), // AQUI icon
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DescriptionPage(
                  title: "About", // AQUI localization
                  descriptions: _aboutDescriptions,
                ),
              ),
            ),
          ),
          ListTile(
            title: const Text("Privacy policy"), // AQUI localization
            leading: const Icon(Icons.privacy_tip), // AQUI icon
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DescriptionPage(
                  title: "Privacy policy", // AQUI localization
                  descriptions: _privacyPolicyDescriptions,
                ),
              ),
            ),
          ),
          // TODO https://developer.android.com/google/play/billing/index.html?authuser=3
          const ListTile(
            title: Text("Support development of this app"), // AQUI localization
            leading: Icon(Icons.volunteer_activism), // AQUI icon
          ),
        ],
      ),
    );
  }
}
