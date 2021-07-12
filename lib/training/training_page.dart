import 'package:flutter/material.dart';
import 'package:kana_plus_plus/shared/routes.dart';
import 'package:kana_plus_plus/training/kana_viewers_widget.dart';
import 'package:kana_plus_plus/training/kana_writer_widget.dart';

class TrainingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("training"),
        leading: IconButton(
          icon: Icon(Icons.exit_to_app),
          onPressed: () => _buildDialog(context),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          LinearProgressIndicator(
            value: 10,
            backgroundColor: Colors.white,
            minHeight: 8,
            color: Colors.green,
          ),
          Spacer(flex: 1),
          Container(
            color: Colors.amber,
            height: 320,
            width: 320,
          ),
          Spacer(flex: 1),
          KanaViewersWidget(),
          Spacer(flex: 1),
          KanaWriterWidget(
            writingHand: WritingHand.right,
          ),
          Spacer(flex: 1),
          ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.review),
              child: Text("test review")),
        ],
      ),
    );
  }

  _buildDialog(context) {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Do you want to finish your training?'),
        content: new Text("You're going to lost this training data."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.popUntil(context, (route) => route.isFirst),
            child: new Text('Yes'),
          ),
        ],
      ),
    );
  }
}
