import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/domain/domain.dart';

class RateButton extends StatelessWidget {
  const RateButton({
    required this.launcher,
    this.iconSize = 24.0,
    this.titleSize = 18.0,
    Key? key,
  }) : super(key: key);

  final IRateLauncher launcher;
  final double iconSize;
  final double titleSize;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () async => launcher.launch(),
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
}
