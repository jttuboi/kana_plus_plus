import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/src/domain/utils/consts.dart';
import 'package:kwriting/src/infrastructure/datasources/icon_url.storage.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:launch_review/launch_review.dart';

class RateButton extends StatelessWidget {
  const RateButton({
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
          onPressed: _onRatePressed,
          iconSize: iconSize,
          icon: SvgPicture.asset(
            IconUrl.rate,
            width: iconSize,
            height: iconSize,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Text(strings.aboutRate, style: aboutIconTextStyle.copyWith(fontSize: titleSize)),
      ],
    );
  }

  Future<void> _onRatePressed() async {
    if (Platform.isIOS) {
      await LaunchReview.launch(iOSAppId: App.iosId);
    } else if (Platform.isAndroid) {
      await LaunchReview.launch(androidAppId: App.androidId);
    } else {
      // if web or desktop, it doesn't support yet.
    }
  }
}
