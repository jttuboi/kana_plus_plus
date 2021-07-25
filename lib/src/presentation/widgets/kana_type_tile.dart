import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/domain/entities/kana_type.dart';
import 'package:kana_plus_plus/src/presentation/pages/selection_option.page.android.dart';
import 'package:kana_plus_plus/src/presentation/providers/kana_type.provider.dart';
import 'package:provider/provider.dart';

class KanaTypeTile extends StatelessWidget {
  const KanaTypeTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JStrings strings = JStrings.of(context)!;
    return Consumer<KanaTypeProvider>(
      builder: (context, provider, child) {
        return ListTile(
          title: Text(strings.settingsKanaType),
          subtitle: Text(provider.text(context)),
          leading: ImageIcon(AssetImage(provider.iconUrl)),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context2) => SelectionOptionPage(
                  title: strings.settingsSelectKanaType,
                  selectedOptionKey: provider.selectedKey,
                  options: provider.options(context),
                  onSelected: (selectedKey) {
                    provider.updateKey(selectedKey as KanaType);
                  }),
            ),
          ),
        );
      },
    );
  }
}
