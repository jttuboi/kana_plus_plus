import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kana_plus_plus/training/training_page.dart';

class KanaPlusPlusApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kana++",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Kana++"),
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black),
        ),
        body: TrainingWidget(),
      ),
    );
  }
}
