import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.deepPurple,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    elevation: 0.0,
  ),
  primaryIconTheme: IconThemeData(
    color: Colors.grey.shade500,
    size: 24.0,
  ),
  scaffoldBackgroundColor: Colors.grey.shade50,
  fontFamily: defaultFontFamily,
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.deepPurple,
);

const TextStyle sliverFlexibleAppBarTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 40,
  fontFamily: defaultTitleFontFamily,
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

const wordDetailTitleStyle = TextStyle(fontSize: 30);
final wordDetailContentStyle = TextStyle(fontSize: 25, color: Colors.grey.shade600);

const defaultTitleFontFamily = 'Permanent Marker';
const defaultFontFamily = 'PT Sans';

const menuTitleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 100,
  fontWeight: FontWeight.w700,
  fontFamily: defaultTitleFontFamily,
);

final menuButtonIconColor = Colors.grey.shade200;

final menuButtonTextStyle = TextStyle(
  color: menuButtonIconColor,
  fontSize: 30,
  fontFamily: defaultTitleFontFamily,
);

const darkPurple = Color.fromRGBO(58, 39, 89, 1);

final defaultLocale = JStrings.supportedLocales.first;

const aboutAppVersionTitleTextStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);

const aboutAppVersionTextStyle = TextStyle(fontSize: 18.0);

const aboutDeveloperTitleTextStyle = TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold);

const aboutDeveloperTextStyle = TextStyle(fontSize: 20.0);

const aboutContactTextStyle = TextStyle(fontSize: 18.0, color: Colors.blue, decoration: TextDecoration.underline);

final aboutIconTextStyle = TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: Colors.deepPurple.withOpacity(0.8),
);

final preTrainingPlayIconThemeData = IconThemeData(
  color: Colors.grey.shade300,
  size: 40.0,
);
