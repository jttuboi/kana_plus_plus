import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/domain/entities/writing_hand.dart';
import 'package:kana_plus_plus/src/views/android/pages/selection_option.page.dart';
import 'package:kana_plus_plus/src/presentation/providers/writing_hand_provider.dart';
import 'package:provider/provider.dart';

class WritingHandTile extends StatelessWidget {
  const WritingHandTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JStrings strings = JStrings.of(context)!;
    return Consumer<WritingHandProvider>(
      builder: (context, provider, child) {
        return ListTile(
          title: Text(strings.settingsWritingHand),
          subtitle: Text(provider.text(context)),
          leading: ImageIcon(AssetImage(provider.iconUrl)),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context2) => SelectionOptionPage(
                title: strings.settingsSelectWritingHand,
                selectedOptionKey: provider.selectedKey,
                options: provider.options(context),
                onSelected: (selectedKey) {
                  provider.updateKey(selectedKey as WritingHand);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
