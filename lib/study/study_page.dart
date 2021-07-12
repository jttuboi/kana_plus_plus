import 'package:flutter/material.dart';
import 'package:kana_plus_plus/shared/routes.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Study"),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.kana),
            child: Text("A"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.kana),
            child: Text("KA"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.kana),
            child: Text("TA"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.kana),
            child: Text("SA"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.kana),
            child: Text("MA"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.kana),
            child: Text("RA"),
          ),
        ],
      ),
    );
  }
}
