import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/domain/domain.dart';
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
        Text(
          strings.aboutRate,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.withOpacity(0.8),
            fontSize: titleSize,
          ),
        ),
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
