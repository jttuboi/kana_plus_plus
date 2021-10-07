import 'package:flutter/cupertino.dart';

@Deprecated("I'm not going to implement iOS version. If you want to implement, uncomment the line in main.dart to open iOS execution.")
class IosApp extends StatelessWidget {
  @Deprecated("I'm not going to implement iOS version. If you want to implement, uncomment the line in main.dart to open iOS execution.")
  const IosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'KWriting',
      debugShowCheckedModeBanner: false, // remove before deploy
      home: Container(),
    );
  }
}
