import "package:flutter/material.dart";

class WordPage extends StatelessWidget {
  const WordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("word"),
      ),
      body: const Center(
        child: Text("a informacao do word deve ficar aqui"),
      ),
    );
  }
}
