import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GridView.count(
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.study),
              child: const Icon(Icons.menu_book, size: 80),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.preTraining),
              child: const Icon(Icons.mode_edit, size: 80),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.words),
              child: const Icon(Icons.style, size: 80),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, Routes.settings),
              child: const Icon(Icons.settings, size: 80),
            ),
          ],
        ),
      ),
    );
  }
}
