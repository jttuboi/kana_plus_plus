import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class WritingHandTile extends StatelessWidget {
  const WritingHandTile({
    required this.writingHand,
    required this.iconUrl,
    required this.options,
    required this.updateWritingHand,
    Key? key,
  }) : super(key: key);

  final WritingHand writingHand;
  final String iconUrl;
  final List<SelectionOptionItem> Function(String Function(WritingHand writingHand) writingHandText) options;
  final Function(WritingHand writingHand) updateWritingHand;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return ListTile(
      title: Text(strings.settingsWritingHand),
      subtitle: Text(_getText(context, writingHand)),
      leading: SizedBox(
        height: double.infinity,
        child: SvgPicture.asset(iconUrl, color: defaultTileIconColor, width: defaultTileIconSize),
      ),
      onTap: () => Navigator.pushNamed(
        context,
        SelectionOptionPage.routeName,
        arguments: {
          SelectionOptionPage.argTitle: strings.settingsSelectWritingHand,
          SelectionOptionPage.argBannerUrl: BannerUrl.writingHand,
          SelectionOptionPage.argSelectedOptionKey: writingHand,
          SelectionOptionPage.argOptions: options((pWritingHand) {
            return _getText(context, pWritingHand);
          }),
          SelectionOptionPage.argOnSelected: (selectedKey) {
            updateWritingHand(selectedKey as WritingHand);
          },
        },
      ),
    );
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
