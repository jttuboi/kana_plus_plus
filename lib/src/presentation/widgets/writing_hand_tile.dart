import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/src/data/datasources/banner_url.storage.dart';
import 'package:kwriting/src/domain/utils/writing_hand.dart';
import 'package:kwriting/src/presentation/arguments/selection_option_arguments.dart';
import 'package:kwriting/src/presentation/pages/selection_option.page.android.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';

class WritingHandTile extends StatelessWidget {
  const WritingHandTile({
    Key? key,
    required this.writingHand,
    required this.iconUrl,
    required this.options,
    required this.updateWritingHand,
  }) : super(key: key);

  final WritingHand writingHand;
  final String iconUrl;
  final List<SelectionOptionArguments> Function(String Function(WritingHand writingHand) writingHandText) options;
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
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context2) => SelectionOptionPage(
            title: strings.settingsSelectWritingHand,
            bannerUrl: BannerUrl.writingHand,
            selectedOptionKey: writingHand,
            options: options((pWritingHand) {
              return _getText(context, pWritingHand);
            }),
            onSelected: (selectedKey) {
              updateWritingHand(selectedKey as WritingHand);
            },
          ),
        ),
      ),
    );
  }

  String _getText(BuildContext context, WritingHand key) {
    final strings = JStrings.of(context)!;
    if (key.isLeft) return strings.settingsWritingHandLeft;
    if (key.isRight) return strings.settingsWritingHandRight;
    return '';
  }
}
