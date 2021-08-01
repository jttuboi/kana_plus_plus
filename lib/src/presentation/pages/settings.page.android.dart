import "package:flutter/material.dart";
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/domain/usecases/settings.controller.dart';
import 'package:kana_plus_plus/src/presentation/state_management/settings.state_management.dart';
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
  const SettingsPage(this.controller, {Key? key}) : super(key: key);

  final SettingsController controller;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final SettingsStateManagement _stateManagement;

  @override
  void initState() {
    super.initState();
    _stateManagement = SettingsStateManagement(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    final JStrings strings = JStrings.of(context)!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(widget.controller),
        ),
        ChangeNotifierProvider(
          create: (context) => WritingHandProvider(widget.controller),
        ),
        ChangeNotifierProvider(
          create: (context) => DarkThemeProvider(widget.controller),
        ),
        ChangeNotifierProvider(
          create: (context) => ShowHintProvider(widget.controller),
        ),
        ChangeNotifierProvider(
          create: (context) => KanaTypeProvider(widget.controller),
        ),
        ChangeNotifierProvider(
          create: (context) => QuantityOfWordsProvider(widget.controller),
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
              Consumer<WritingHandProvider>(
                builder: (context, provider, child) {
                  return WritingHandTile(
                    writingHand: provider.writingHand,
                    iconUrl: provider.iconUrl,
                    getOptions: provider.getOptions,
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
                    getOptions: provider.getOptions,
                    updateKanaType: provider.updateKanaType,
                  );
                },
              ),
              Consumer<QuantityOfWordsProvider>(
                builder: (context, provider, child) {
                  return QuantityOfWordsTile(
                    quantity: provider.quantity,
                    iconUrl: provider.iconUrl,
                    minWords: provider.minWords,
                    maxWords: provider.maxWords,
                    updateQuantity: provider.updateQuantity,
                  );
                },
              ),
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
