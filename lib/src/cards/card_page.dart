import "package:flutter/material.dart";

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("card"),
      ),
      body: const Center(
        child: Text("a informacao do card deve ficar aqui"),
      ),
    );
  }
}
