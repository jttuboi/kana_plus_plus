import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_result.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';
import 'package:kana_plus_plus/src/presentation/widgets/review_tile.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({
    Key? key,
    required this.wordsResult,
  }) : super(key: key);

  final List<WordResult> wordsResult;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    //print(MediaQuery.of(context).padding.top + kToolbarHeight);
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.isFirst);
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: CustomScrollView(
          semanticChildCount: wordsResult.length + 1,
          slivers: [
            SliverAppBar(
              flexibleSpace: LayoutBuilder(builder: (context, constraints) {
                final isCollapsed = constraints.biggest.height <= MediaQuery.of(context).padding.top + kToolbarHeight + 1;
                return FlexibleSpaceBar(
                  centerTitle: true,
                  // TODO mudar a fonte do review title, talvez aumentar a fonte
                  title: isCollapsed ? null : Text(strings.reviewTitle, style: appBarZoomTextStyle),
                  // TODO criar um background pro review
                  background:
                      Container(color: Theme.of(context).primaryColor, child: SvgPicture.asset('lib/assets/images/kanas/あ.svg', fit: BoxFit.cover)),
                );
              }),
              leading: IconButton(
                icon: SvgPicture.asset(IconUrl.backMenu, color: Theme.of(context).primaryIconTheme.color),
                onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              ),
              expandedHeight: appBarExpandedHeight(context),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return index.isEven ? ReviewTile(wordResult: wordsResult[index ~/ 2]) : const Divider(indent: 72.0);
                },
                semanticIndexCallback: (widget, localIndex) {
                  return localIndex.isEven ? localIndex ~/ 2 : null;
                },
                childCount: max(0, wordsResult.length * 2 - 1),
              ),
            ),

            // SliverFillRemaining(
            //   child: ListView.separated(
            //     padding: EdgeInsets.zero,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: wordsResult.length,
            //     itemBuilder: (context, index) => ReviewTile(wordResult: wordsResult[index]),
            //     separatorBuilder: (context, index) => const Divider(thickness: 1.0, indent: 16.0, endIndent: 16.0),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
