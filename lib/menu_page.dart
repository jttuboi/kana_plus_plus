import "package:flutter/material.dart";
import "package:kana_plus_plus/shared/routes.dart";

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orangeAccent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.study),
            child: const Text("study"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.preTraining),
            child: const Text("training"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.cards),
            child: const Text("cards"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.settings),
            child: const Text("settings"),
          ),
        ],
      ),
    );
  }
}
