import "package:flutter/material.dart";
import "package:kana_plus_plus/shared/routes.dart";

class PreTrainingPage extends StatelessWidget {
  const PreTrainingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configure training"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Switch.adaptive(value: false, onChanged: (value) {}),
              const Text("show hint"),
            ],
          ),
          const Text("quantity cards"),
          Slider(
            value: 5,
            onChanged: (value) {},
            min: 5,
            max: 20,
            label: "cards",
          ),
          ToggleButtons(
            children: const [
              Icon(Icons.translate),
              Icon(Icons.translate_outlined),
              Icon(Icons.translate_rounded),
            ],
            isSelected: const [
              false,
              false,
              true,
            ],
            selectedBorderColor: Colors.amber,
            onPressed: (index) {},
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.training),
            child: const Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}
