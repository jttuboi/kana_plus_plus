import "package:flutter/material.dart";
import 'package:kana_plus_plus/src/presentation/routes.dart';

class WordsPage extends StatelessWidget {
  const WordsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Words"),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.word),
            child: const Text("rain"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.word),
            child: const Text("rain"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.word),
            child: const Text("rain"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.word),
            child: const Text("rain"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.word),
            child: const Text("rain"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.word),
            child: const Text("rain"),
          ),
        ],
      ),
    );
  }
}
