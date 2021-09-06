import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';

class ShowHintTile extends StatelessWidget {
  const ShowHintTile({
    Key? key,
    required this.showHint,
    required this.iconUrl,
    required this.updateShowHint,
  }) : super(key: key);

  final bool showHint;
  final String iconUrl;
  final Function(bool isShowHint) updateShowHint;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return SwitchListTile(
      title: Text(strings.settingsShowHint),
      value: showHint,
      onChanged: updateShowHint,
      secondary: SvgPicture.asset(iconUrl, color: defaultTileIconColor, width: defaultTileIconSize),
    );
  }
}
