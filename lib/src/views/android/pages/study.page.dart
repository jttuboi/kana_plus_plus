import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/presentation/routes.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study"),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.kana),
            child: const Text("A"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.kana),
            child: const Text("KA"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.kana),
            child: const Text("TA"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.kana),
            child: const Text("SA"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.kana),
            child: const Text("MA"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.kana),
            child: const Text("RA"),
          ),
        ],
      ),
    );
  }
}
