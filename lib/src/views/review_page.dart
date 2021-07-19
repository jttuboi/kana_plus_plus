import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/models/kana_result.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({
    Key? key,
    required this.wordsResult,
  }) : super(key: key);

  final List<List<KanaResult>> wordsResult;

  @override
  Widget build(BuildContext context) {
    wordsResult.forEach((kanasResult) {
      print(kanasResult);
    });

    return //WillPopScope(child:

        Scaffold(
      appBar: AppBar(
        title: const Text("review"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.popUntil(context, (route) => route.isFirst),
        ),
      ),
    ); //,
    //onWillPop: () async => false);
  }
}
