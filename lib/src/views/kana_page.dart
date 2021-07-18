import "package:flutter/material.dart";

class KanaPage extends StatelessWidget {
  const KanaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("kana ?"),
      ),
      body: const Center(
        child: Text("estudo da kana deve ser mostrado aqui"),
      ),
    );
  }
}
