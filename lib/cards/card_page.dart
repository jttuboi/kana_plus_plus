import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  const CardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("card"),
      ),
      body: Center(
        child: Container(
          child: Text("a informacao do card deve ficar aqui"),
        ),
      ),
    );
  }
}
