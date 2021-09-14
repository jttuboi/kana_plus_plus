import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/data/datasources/banner_url.storage.dart';
import 'package:kana_plus_plus/src/domain/controllers/review.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/word_result.dart';
import 'package:kana_plus_plus/src/presentation/widgets/flexible_scaffold.dart';
import 'package:kana_plus_plus/src/presentation/widgets/review_tile.dart';
import 'package:kana_plus_plus/src/presentation/widgets/support_button.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({
    Key? key,
    required this.reviewController,
    required this.wordsResult,
  }) : super(key: key);

  final ReviewController reviewController;
  final List<WordResult> wordsResult;

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  @override
  void initState() {
    super.initState();
    // print(widget.reviewController.showRateApp);
    // if (widget.reviewController.showRateApp) {
    //   // TODO add dialog for app rating and review
    //   // it's good to show a dialog after 2 or 3 seconds after 10 or more training made it
    //   // this dialog ask if have you enjoy this app? Please, give a feedback.
    //   // this dialog has buttons yes and no. No option closes the box, Yes option open in app review dialog.
    // }
  }

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    //print(MediaQuery.of(context).padding.top + kToolbarHeight);
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.isFirst);
        return false;
      },
      child: FlexibleScaffold(
        title: strings.reviewTitle,
        bannerUrl: BannerUrl.review,
        onBackButtonPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
        actions: const [SupportButton(isAppBarIcon: true)],
        sliverContent: SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return index.isEven ? ReviewTile(wordResult: widget.wordsResult[index ~/ 2]) : const Divider(indent: 72.0);
              },
              semanticIndexCallback: (widget, localIndex) {
                return localIndex.isEven ? localIndex ~/ 2 : null;
              },
              childCount: max(0, widget.wordsResult.length * 2 - 1),
            ),
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
      ),
    );
  }
}
