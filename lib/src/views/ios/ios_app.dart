import 'package:flutter/cupertino.dart';

class IosApp extends StatelessWidget {
  const IosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "Kana++",
      debugShowCheckedModeBanner: false, // TODO remover antes de dar deploy
      home: Container(),
    );
  }
}
