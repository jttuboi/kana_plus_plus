import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/src/domain/utils/consts.dart';
import 'package:kwriting/src/infrastructure/datasources/icon_url.storage.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:share_plus/share_plus.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    Key? key,
    this.iconSize = 24.0,
    this.titleSize = 18.0,
  }) : super(key: key);

  final double iconSize;
  final double titleSize;

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
        Text(strings.aboutShare, style: aboutIconTextStyle.copyWith(fontSize: titleSize)),
      ],
    );
  }

  Future<void> _onSharePressed(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    final sharePositionOrigin = box!.localToGlobal(Offset.zero) & box.size;
    if (Platform.isIOS) {
      await Share.share(App.appStoreUrl, subject: App.appStoreUrl, sharePositionOrigin: sharePositionOrigin);
    } else if (Platform.isAndroid) {
      await Share.share(App.playStoreUrl, subject: Default.emailSubject, sharePositionOrigin: sharePositionOrigin);
    } else {
      // if web or desktop, it doesn't support yet.
    }
  }
}
