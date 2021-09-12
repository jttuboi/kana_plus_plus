import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    Key? key,
    required this.iconSize,
  }) : super(key: key);

  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => _onSharePressed(context),
          iconSize: iconSize,
          icon: SvgPicture.asset(IconUrl.share, width: iconSize, height: iconSize, color: Theme.of(context).colorScheme.secondary),
        ),
        Text(strings.aboutShare, style: aboutIconTextStyle),
      ],
    );
  }

  Future<void> _onSharePressed(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final sharePositionOrigin = box!.localToGlobal(Offset.zero) & box.size;
    if (Platform.isIOS) {
      await Share.share(AppDefault.appStoreUrl, subject: AppDefault.appStoreUrl, sharePositionOrigin: sharePositionOrigin);
    } else if (Platform.isAndroid) {
      await Share.share(AppDefault.playStoreUrl, subject: Default.emailSubject, sharePositionOrigin: sharePositionOrigin);
    } else {
      // if web or desktop, it doesn't support yet.
    }
  }
}
