import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/presentation/arguments/selection_option.arguments.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';

class SelectionOptionPage extends StatelessWidget {
  const SelectionOptionPage({
    Key? key,
    required this.title,
    required this.bannerUrl,
    required this.selectedOptionKey,
    required this.options,
    required this.onSelected,
  }) : super(key: key);

  final String title;
  final String bannerUrl;
  final dynamic selectedOptionKey;
  final List<SelectionOptionArguments> options;
  final Function(dynamic) onSelected;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        onSelected(selectedOptionKey);
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: FittedBox(fit: BoxFit.fitWidth, child: Text(title, style: appBarZoomTextStyle)),
                ),
                background: Container(color: Theme.of(context).primaryColor, child: SvgPicture.asset(bannerUrl, fit: BoxFit.cover)),
              ),
              leading: IconButton(
                icon: SvgPicture.asset(IconUrl.back, color: Theme.of(context).primaryIconTheme.color),
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              ),
              expandedHeight: appBarExpandedHeight(context),
              pinned: true,
            ),
            SliverFillRemaining(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options[index];
                  return RadioListTile(
                    title: Text(option.label),
                    value: index,
                    groupValue: options.indexWhere((SelectionOptionArguments pOption) {
                      return pOption.key == selectedOptionKey;
                    }),
                    onChanged: (int? value) {
                      onSelected(options[value!].key);
                      Navigator.pop(context);
                    },
                    secondary:
                        (option.iconUrl.isEmpty) ? null : SvgPicture.asset(option.iconUrl, color: defaultTileIconColor, width: defaultTileIconSize),
                    controlAffinity: ListTileControlAffinity.trailing,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
