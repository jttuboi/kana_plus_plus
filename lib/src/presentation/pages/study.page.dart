import 'package:flutter/material.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Study'),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children: [
          ElevatedButton(
            onPressed: () => {},
            child: const Text('A'),
          ),
          ElevatedButton(
            onPressed: () => {},
            child: const Text('KA'),
          ),
          ElevatedButton(
            onPressed: () => {},
            child: const Text('TA'),
          ),
          ElevatedButton(
            onPressed: () => {},
            child: const Text('SA'),
          ),
          ElevatedButton(
            onPressed: () => {},
            child: const Text('MA'),
          ),
          ElevatedButton(
            onPressed: () => {},
            child: const Text('RA'),
          ),
        ],
      ),
    );
  }
}