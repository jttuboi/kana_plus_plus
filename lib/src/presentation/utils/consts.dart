import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.deepPurple,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0.0,
  ),
  primaryIconTheme: IconThemeData(
    color: Colors.grey.shade700,
    size: 24.0,
  ),
  accentIconTheme: IconThemeData(
    color: Colors.grey.shade300,
    size: 40.0,
  ),
  scaffoldBackgroundColor: Colors.grey.shade50,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.deepPurple,
);

const TextStyle appBarZoomTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 40,
);

double appBarExpandedHeight(BuildContext context) {
  return MediaQuery.of(context).size.height * 1 / 5;
}

final Color defaultProgressBarColor = Colors.grey.shade400;
//final Color fillingProgressBarColor = Colors.blueAccent;

final Color correctBorderColor = Colors.blueAccent;
final Color wrongBorderColor = Colors.redAccent;
final Color defaultBorderColor = Colors.grey.shade500;

final writerButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
  overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
  side: MaterialStateBorderSide.resolveWith((states) => const BorderSide(color: Colors.grey)),
  animationDuration: const Duration(milliseconds: 50),
  enableFeedback: false,
);
final Color writerIconButtonColor = Colors.grey.shade700;

final allStrokesPaint = Paint()
  ..isAntiAlias = true
  ..strokeWidth = 14.0
  ..strokeCap = StrokeCap.round
  ..strokeJoin = StrokeJoin.round
  ..color = Colors.black;

final drawingStrokePaint = Paint()
  ..isAntiAlias = true
  ..strokeWidth = 18.0
  ..strokeCap = StrokeCap.round
  ..strokeJoin = StrokeJoin.round
  ..color = Colors.black87;

final userStrokesPaint = Paint()
  ..isAntiAlias = true
  ..strokeWidth = 5.0
  ..strokeCap = StrokeCap.round
  ..strokeJoin = StrokeJoin.round
  ..color = Colors.black;

const reviewTileTitleStyle = TextStyle(fontWeight: FontWeight.bold);

const Color defaultTileIconColor = Colors.grey;
const double defaultTileIconSize = 40;
