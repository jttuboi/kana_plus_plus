import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/views/providers/show_hint.provider.dart';
import 'package:provider/provider.dart';

class ShowHintTile extends StatelessWidget {
  const ShowHintTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JStrings strings = JStrings.of(context)!;
    return Consumer<ShowHintProvider>(
      builder: (context, provider, child) {
        return SwitchListTile(
          title: Text(strings.settingsShowHint),
          value: provider.isShowHint,
          onChanged: (value) {
            provider.updateShowHint(value);
          },
          secondary: ImageIcon(AssetImage(provider.iconUrl)),
        );
      },
    );
  }
}
