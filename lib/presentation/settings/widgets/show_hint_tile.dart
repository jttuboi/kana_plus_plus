import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:provider/provider.dart';

class ShowHintTile extends StatelessWidget {
  const ShowHintTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;

    return Consumer<ShowHintChangeNotifier>(
      builder: (context, changeNotifier, child) {
        return SwitchListTile(
          title: Text(strings.settingsShowHint),
          value: changeNotifier.data.showHint,
          onChanged: changeNotifier.updateShowHint,
          secondary: SvgPicture.asset(changeNotifier.data.iconUrl, color: defaultTileIconColor, width: defaultTileIconSize),
        );
      },
    );
  }
}
