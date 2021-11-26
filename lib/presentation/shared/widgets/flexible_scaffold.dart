import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/domain/domain.dart';

class FlexibleScaffold extends StatefulWidget {
  const FlexibleScaffold({
    required this.title,
    required this.bannerUrl,
    required this.onBackButtonPressed,
    this.isFlexible = true,
    this.actions,
    this.sliverContent,
    Key? key,
  }) : super(key: key);

  final String title;
  final String bannerUrl;
  final VoidCallback onBackButtonPressed;
  final bool isFlexible;
  final List<Widget>? actions;
  final Widget? sliverContent;

  @override
  _FlexibleScaffoldState createState() => _FlexibleScaffoldState();
}

class _FlexibleScaffoldState extends State<FlexibleScaffold> {
  late ScrollController _scrollController;
  Color _shadowColor = Colors.black;
  double _elevation = 4;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _shadowColor = _isSliverAppBar20Collapsed ? Colors.transparent : Colors.black;
          _elevation = _isSliverAppBar20Collapsed ? 0.0 : 4.0;
        });
      });
  }

  bool get _isSliverAppBar20Collapsed {
    final expandedHeight20 = appBarExpandedHeight(context) * 0.2; // 20% of appBarExpandedHeight
    return _scrollController.hasClients && _scrollController.offset > expandedHeight20;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: widget.isFlexible,
      body: CustomScrollView(
        physics: widget.isFlexible ? null : const NeverScrollableScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            flexibleSpace: widget.isFlexible ? _buildFlexible(context) : _buildFixed(context),
            expandedHeight: appBarExpandedHeight(context),
            leading: IconButton(
              icon: SvgPicture.asset(IconUrl.back, color: Theme.of(context).primaryIconTheme.color),
              onPressed: widget.onBackButtonPressed,
            ),
            actions: widget.actions,
            pinned: true,
            shadowColor: _shadowColor,
            elevation: _elevation,
            forceElevated: true,
          ),
          if (widget.sliverContent != null) widget.sliverContent!
        ],
      ),
    );
  }

  Widget _buildFixed(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(
            widget.title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: Device.get().isTablet ? 56 : 40,
              fontFamily: 'Permanent Marker',
            ),
          ),
        ),
      ),
      background: Container(
        color: Theme.of(context).primaryColor,
        child: SvgPicture.asset(
          widget.bannerUrl,
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
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Device.get().isTablet ? 56 : 40,
                        fontFamily: 'Permanent Marker',
                      ),
                    ),
                  ),
                ),
          background: Container(
            color: Theme.of(context).primaryColor,
            child: SvgPicture.asset(
              widget.bannerUrl,
              fit: BoxFit.cover,
              color: Theme.of(context).toggleableActiveColor,
            ),
          ),
        );
      },
    );
  }
}