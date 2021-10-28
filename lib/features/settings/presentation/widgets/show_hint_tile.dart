import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/core.dart';

class ShowHintTile extends StatelessWidget {
  const ShowHintTile({
    required this.showHint,
    required this.iconUrl,
    required this.updateShowHint,
    Key? key,
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
