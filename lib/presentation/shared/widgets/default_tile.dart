import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/domain/domain.dart';

class DefaultTile extends StatelessWidget {
  const DefaultTile({required this.title, required this.subtitle, required this.iconUrl, this.onTap, Key? key}) : super(key: key);

  final String title;
  final String subtitle;
  final String iconUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      leading: SizedBox(
        height: double.infinity,
        child: SvgPicture.asset(iconUrl, color: defaultTileIconColor, width: defaultTileIconSize),
      ),
      onTap: onTap,
    );
  }
}
