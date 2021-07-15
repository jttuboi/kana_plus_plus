import "package:flutter/material.dart";

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("settings"),
      ),
      body: Column(
        children: const [
          Text("basic section"),
          Text("language"),
          Text("writing hand: left or right"),
          Text("default section"),
          Text("show hint (true, false)"),
          Text("quantity per training (min: 5, max: 20)"),
          Text(" kana type (hiragana, katakana, both)"),
          Text("paid section"),
          Text("paid unlock more cards and ads free"),
          Text("donation??"),
          Text("about section"),
          Text("information about me"),
          Text("where data comes from"),
          Text("policy of use ou alguma coisa sobre isso"),
        ],
      ),
    );
  }
}
