import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';

class SliverFlexibleAppBar extends StatelessWidget {
  const SliverFlexibleAppBar({
    Key? key,
    required this.title,
    required this.bannerUrl,
    this.isFlexible = true,
    required this.onBackButtonPressed,
    this.actions,
  }) : super(key: key);

  final String title;
  final String bannerUrl;
  final bool isFlexible;
  final VoidCallback onBackButtonPressed;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      flexibleSpace: isFlexible ? _buildFlexible(context) : _buildFixed(context),
      expandedHeight: appBarExpandedHeight(context),
      leading: IconButton(
        icon: SvgPicture.asset(IconUrl.back, color: Theme.of(context).primaryIconTheme.color),
        onPressed: onBackButtonPressed,
      ),
      actions: actions,
      pinned: true,
    );
  }

  Widget _buildFixed(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FittedBox(fit: BoxFit.fitWidth, child: Text(title, style: sliverFlexibleAppBarTextStyle)),
      ),
      background: Container(
        color: Theme.of(context).primaryColor,
        child: SvgPicture.asset(
          bannerUrl,
          fit: BoxFit.cover,
          color: Theme.of(context).toggleableActiveColor,
        ),
      ),
    );
  }

  Widget _buildFlexible(BuildContext context) {
    return LayoutBuilder(
      builder: (context2, constraints) {
        final isCollapsed = constraints.biggest.height <= MediaQuery.of(context2).padding.top + kToolbarHeight + 1;
        return FlexibleSpaceBar(
          centerTitle: true,
          title: isCollapsed
              ? null
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: FittedBox(fit: BoxFit.fitWidth, child: Text(title, style: sliverFlexibleAppBarTextStyle)),
                ),
          background: Container(
            color: Theme.of(context).primaryColor,
            child: SvgPicture.asset(
              bannerUrl,
              fit: BoxFit.cover,
              color: Theme.of(context).toggleableActiveColor,
            ),
          ),
        );
      },
    );
  }
}
