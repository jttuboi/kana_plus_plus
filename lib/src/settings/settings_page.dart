import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/settings/description.dart';
import 'package:kana_plus_plus/src/settings/description_page.dart';
import 'package:kana_plus_plus/src/settings/selection_option.dart';
import 'package:kana_plus_plus/src/settings/selection_option_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _languageSelectedIdx = 0; // english
  final List<SelectionOption> _languageOptions = [
    const SelectionOption("English"),
    const SelectionOption("Português"),
    const SelectionOption("Spañol"),
  ];

  int _writingHandSelectedIdx = 1; // right hand
  final List<SelectionOption> _writingHandOptions = [
    const SelectionOption("Left hand", icon: Icon(Icons.swipe)),
    const SelectionOption("Right hand", icon: Icon(Icons.pan_tool)),
  ];

  bool _darkMode = false;
  bool _showHint = false;

  int _quantityOfCards = 5;
  double step = 1;
  double min = 5;
  double max = 20;

  int _kanaSelectedIdx = 2; // both
  final List<SelectionOption> _kanaOptions = [
    const SelectionOption("Only hiragana",
        icon: Icon(Icons.translate_outlined)),
    const SelectionOption("Only katakana", icon: Icon(Icons.translate_rounded)),
    const SelectionOption("Hiragana/Katakana", icon: Icon(Icons.translate)),
  ];

  final List<Description> _aboutDescriptions = [
    Description.title("blablable"),
    Description.content("informaçoes sobre mim"),
    Description.content("contato"),
    Description.content("de onde os dados vieram"),
  ];

  final List<Description> _privacyPolicyDescriptions = [
    Description.title("citar sobre uso"),
    Description.content(
        "blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          const _SubHeaderTile(title: "Basic"),
          ListTile(
            title: const Text("Language"),
            // TODO  ver como escrever "(default)" na frente da palavra
            subtitle: Text(_languageOptions[_languageSelectedIdx].title),
            leading: const Icon(Icons.translate),
            onTap: () async {
              final selectedIdx = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectionOptionPage(
                    title: "Select language",
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
            title: const Text("Writing hand"),
            subtitle: Text(_writingHandOptions[_writingHandSelectedIdx].title),
            leading: _writingHandOptions[_writingHandSelectedIdx].icon,
            onTap: () async {
              final selectedIdx = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectionOptionPage(
                    title: "Select writing hand",
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
            title: const Text("Dark mode"),
            value: _darkMode,
            onChanged: (value) => setState(() {
              _darkMode = value;
            }),
            secondary: _darkMode
                ? const Icon(Icons.dark_mode)
                : const Icon(Icons.light_mode),
          ),
          const Divider(),
          const _SubHeaderTile(title: "Default training setting"),
          SwitchListTile(
            title: const Text("Show hint"),
            value: _showHint,
            onChanged: (value) => setState(() {
              _showHint = value;
            }),
            secondary: const Icon(Icons.highlight_alt), // desenhar icone
          ),
          ListTile(
            title: const Text("Kana type"),
            subtitle: Text(_kanaOptions[_kanaSelectedIdx].title),
            leading: _kanaOptions[_kanaSelectedIdx].icon,
            onTap: () async {
              final selectedIdx = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectionOptionPage(
                    title: "Select kana type",
                    optionSelectedIndex: _kanaSelectedIdx,
                    options: _kanaOptions,
                  ),
                ),
              );
              setState(() {
                _kanaSelectedIdx = selectedIdx as int;
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.recent_actors),
            title: const Text("Quantity of cards"),
            subtitle: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackShape: _CustomTrackShape(),
              ),
              child: Slider(
                value: _quantityOfCards.toDouble(),
                onChanged: (value) {
                  setState(() {
                    _quantityOfCards = value.toInt();
                  });
                },
                divisions: (max - min) ~/ step,
                label: _quantityOfCards.toString(),
                min: min,
                max: max,
              ),
            ),
          ),
          const Divider(),
          const _SubHeaderTile(title: "Others"),
          ListTile(
            title: const Text("About"),
            leading: const Icon(Icons.info),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DescriptionPage(
                    title: "About",
                    descriptions: _aboutDescriptions,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Privacy policy"),
            leading: const Icon(Icons.privacy_tip),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DescriptionPage(
                    title: "Privacy policy",
                    descriptions: _privacyPolicyDescriptions,
                  ),
                ),
              );
            },
          ),
          // TODO https://developer.android.com/google/play/billing/index.html?authuser=3
          const ListTile(
            title: Text("Support development of this app"),
            leading: Icon(Icons.volunteer_activism),
          ),
        ],
      ),
    );
  }
}

class _SubHeaderTile extends StatelessWidget {
  const _SubHeaderTile({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Text(title, style: Theme.of(context).textTheme.subtitle2),
    );
  }
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx + 6;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 22;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
