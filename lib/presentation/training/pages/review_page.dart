import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage._({required this.reviewController, required this.wordsResult, Key? key}) : super(key: key);

  static const routeName = '/review';
  static const argWordsResult = 'argWordsResult';

  static Route route({List<WordViewModel>? wordsResult}) {
    return MaterialPageRoute(builder: (context) {
      return ReviewPage._(reviewController: ReviewController(statisticsRepository: StatisticsRepository()), wordsResult: wordsResult ?? const []);
    });
  }

  final ReviewController reviewController;
  final List<WordViewModel> wordsResult;

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
      ),
    );
  }
}
