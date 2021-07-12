import 'package:flutter/material.dart';
import 'package:kana_plus_plus/shared/routes.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cards"),
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.card),
            child: Text("rain"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.card),
            child: Text("rain"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.card),
            child: Text("rain"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.card),
            child: Text("rain"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.card),
            child: Text("rain"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, Routes.card),
            child: Text("rain"),
          ),
        ],
      ),
    );
  }
}
