import 'dart:io';

import 'package:kwriting/domain/domain.dart';
import 'package:launch_review/launch_review.dart';

class RateLauncher {
  RateLauncher();

  Future<void> launch() async {
    if (Platform.isIOS) {
      await LaunchReview.launch(iOSAppId: App.iosId);
    } else if (Platform.isAndroid) {
      await LaunchReview.launch(androidAppId: App.androidId);
    } else {
      // if web or desktop, it doesn't support yet.
    }
  }
}
