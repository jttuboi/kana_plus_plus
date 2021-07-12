import 'package:flutter/material.dart';

class KanaPage extends StatelessWidget {
  const KanaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("kana ?"),
      ),
      body: Center(
        child: Container(
          child: Text("estudo da kana deve ser mostrado aqui"),
        ),
      ),
    );
  }
}
