import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/domain/domain.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({
    required this.launcher,
    this.iconSize = 24.0,
    this.titleSize = 18.0,
    Key? key,
  }) : super(key: key);

  final ShareLauncher launcher;
  final double iconSize;
  final double titleSize;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () async => launcher.launch(context),
          iconSize: iconSize,
          icon: SvgPicture.asset(IconUrl.share, width: iconSize, height: iconSize, color: Theme.of(context).colorScheme.secondary),
        ),
        Text(
          strings.aboutShare,
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
