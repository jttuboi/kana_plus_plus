import 'package:flutter/material.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return //WillPopScope(child:

        Scaffold(
      appBar: AppBar(
        title: Text("review"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () =>
              Navigator.popUntil(context, (route) => route.isFirst),
        ),
      ),
    ); //,
    //onWillPop: () async => false);
  }
}
