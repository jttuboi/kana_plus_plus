import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';

class SupportButton extends StatelessWidget {
  const SupportButton({
    Key? key,
    this.iconSize = 24.0,
    this.isAppBarIcon = false,
  }) : super(key: key);

  final double iconSize;
  final bool isAppBarIcon;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return isAppBarIcon
        ? Padding(
            padding: const EdgeInsets.all(4.0),
            child: IconButton(
              onPressed: () => _onSupportPressed(context),
              icon: SvgPicture.asset(IconUrl.support, width: iconSize, height: iconSize, color: Theme.of(context).primaryIconTheme.color),
            ),
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _onSupportPressed(context),
                iconSize: iconSize,
                icon: SvgPicture.asset(IconUrl.support, width: iconSize, height: iconSize, color: Theme.of(context).colorScheme.secondary),
              ),
              Text(strings.aboutSupport, style: aboutIconTextStyle),
            ],
          );
  }

  Future<void> _onSupportPressed(BuildContext context) async {
    final strings = JStrings.of(context)!;
    // TODO put ads here
    //this shows after close ads
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(strings.aboutSupportMessage),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
    ));
  }
}
