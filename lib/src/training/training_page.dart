import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/shared/icons.dart';
import 'package:kana_plus_plus/src/shared/routes.dart';
import 'package:kana_plus_plus/src/training/kana_viewers_widget.dart';
import 'package:kana_plus_plus/src/training/kana_writer_widget.dart';

class TrainingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _buildDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("training"),
          leading: IconButton(
            icon: KIcons.quit,
            onPressed: () => _buildDialog(context),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const LinearProgressIndicator(
              value: 10,
              backgroundColor: Colors.white,
              minHeight: 8,
              color: Colors.green,
            ),
            const Spacer(),
            Container(
              color: Colors.amber,
              height: 320,
              width: 320,
            ),
            const Spacer(),
            const KanaViewersWidget(),
            const Spacer(),
            const KanaWriterWidget(
              writingHand: WritingHand.right,
            ),
            const Spacer(),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, Routes.review),
                child: const Text("test review")),
          ],
        ),
      ),
    );
  }

  void _buildDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Do you want to finish your training?"),
        content: const Text("You're going to lost this training data."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }
}
