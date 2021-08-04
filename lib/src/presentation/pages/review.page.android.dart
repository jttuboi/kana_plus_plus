import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/presentation/arguments/word_result.dart';
import 'package:kana_plus_plus/src/presentation/state_management/review.state_management.dart';
import 'package:kana_plus_plus/src/presentation/widgets/review_tile.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({
    Key? key,
    required this.reviewStateManagement,
    required this.wordsResult,
  }) : super(key: key);

  final ReviewStateManagement reviewStateManagement;
  final List<WordResult> wordsResult;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.popUntil(context, (route) => route.isFirst);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("review"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
          ),
        ),
        body: ListView.separated(
          itemCount: wordsResult.length,
          itemBuilder: (context, index) {
            return ReviewTile(
              wordsResult[index],
              squareImageUrl: reviewStateManagement.squareImageUrl,
              correctImageUrl: reviewStateManagement.correctImageUrl,
              wrongImageUrl: reviewStateManagement.wrongImageUrl,
            );
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
      ),
    );
  }
}
