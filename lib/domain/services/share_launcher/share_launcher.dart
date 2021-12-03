import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:share_plus/share_plus.dart';

class ShareLauncher {
  Future<void> launch(BuildContext context) async {
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
