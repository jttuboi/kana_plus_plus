import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kwriting/menu/presentation/widgets/flexible_scaffold.dart';
import 'package:kwriting/settings/presentation/widgets/support_button.dart';
import 'package:kwriting/src/infrastructure/datasources/banner_url.storage.dart';
import 'package:kwriting/training/domain/use_cases/review.controller.dart';
import 'package:kwriting/training/presentation/arguments/word_result.dart';
import 'package:kwriting/training/presentation/widgets/review_tile.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({
    required this.reviewController,
    required this.wordsResult,
    Key? key,
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
          padding: const EdgeInsets.symmetric(vertical: 16),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return index.isEven ? ReviewTile(wordResult: widget.wordsResult[index ~/ 2]) : const Divider(indent: 72);
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