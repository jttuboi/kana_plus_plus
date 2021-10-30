import 'package:flutter/material.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';
import 'package:provider/provider.dart';

class WritingHandTile extends StatelessWidget {
  const WritingHandTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;

    return Consumer<WritingHandChangeNotifier>(
      builder: (context, changeNotifier, child) {
        return DefaultTile(
          title: strings.settingsWritingHand,
          subtitle: _getText(context, changeNotifier.data.writingHand),
          iconUrl: changeNotifier.data.iconUrl,
          onTap: () => Navigator.pushNamed(
            context,
            SelectionOptionPage.routeName,
            arguments: {
              SelectionOptionPage.argTitle: strings.settingsSelectWritingHand,
              SelectionOptionPage.argBannerUrl: BannerUrl.writingHand,
              SelectionOptionPage.argSelectedOptionKey: changeNotifier.data.writingHand,
              SelectionOptionPage.argOptions: _options(context, changeNotifier.writingHandsData),
              SelectionOptionPage.argOnSelected: (selectedKey) {
                changeNotifier.updateWritingHand(selectedKey as WritingHand);
              },
            },
          ),
        );
      },
    );
  }

  List<SelectionOptionItem> _options(BuildContext context, List<WritingHandData> writingHandsData) {
    return writingHandsData.map((data) {
      return SelectionOptionItem(
        key: data.writingHand,
        label: _getText(context, data.writingHand),
        iconUrl: data.iconUrl,
      );
    }).toList();
  }

  String _getText(BuildContext context, WritingHand key) {
    final strings = JStrings.of(context)!;
    if (key.isLeft) {
      return strings.settingsWritingHandLeft;
    }
    if (key.isRight) {
      return strings.settingsWritingHandRight;
    }
    return '';
  }
}
