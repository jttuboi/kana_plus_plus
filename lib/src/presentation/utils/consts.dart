import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:introduction_screen/introduction_screen.dart';

const defaultTitleFontFamily = 'Permanent Marker';
const defaultFontFamily = 'PT Sans';

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

const darkPurple = Color.fromRGBO(58, 39, 89, 1);

final defaultLocale = JStrings.supportedLocales.first;

const TextStyle sliverFlexibleAppBarTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 40,
  fontFamily: defaultTitleFontFamily,
);

double appBarExpandedHeight(BuildContext context) {
  return MediaQuery.of(context).size.height * 1 / 5;
}

const Color defaultTileIconColor = Colors.grey;
const double defaultTileIconSize = 40;

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

final menuBackgroundBackPaint = Paint()..color = Colors.deepPurple.shade200;

final menuBackgroundMiddlePaint = Paint()..color = Colors.deepPurple.shade400;

final menuBackgroundMiddleBlurPaint = Paint()
  ..color = Colors.black87
  ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);

final menuBackgroundFrontPaint = Paint()..color = darkPurple;

final menuBackgroundFrontBlurPaint = Paint()
  ..color = Colors.black87
  ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);

final introductionDotsDecorator = DotsDecorator(
  size: const Size(10, 10),
  color: Colors.grey.shade400,
  activeSize: const Size(20, 10),
  activeColor: Colors.grey.shade200,
  activeShape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  ),
);

final introductionPageDecoration = PageDecoration(
  titleTextStyle: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    fontFamily: defaultTitleFontFamily,
    color: Colors.grey.shade200,
    letterSpacing: 2.0,
  ),
  bodyTextStyle: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.grey.shade200,
  ),
  descriptionPadding: const EdgeInsets.all(16.0).copyWith(bottom: 0.0),
  imagePadding: const EdgeInsets.all(24),
);

const introductionButtonTextStyle = TextStyle(fontSize: 17.0, letterSpacing: 1.0, fontWeight: FontWeight.bold);
final introductionButtonStyle = ButtonStyle(backgroundColor: MaterialStateProperty.all(darkPurple));

final preTrainingPlayIconThemeData = IconThemeData(
  color: Colors.grey.shade300,
  size: 40.0,
);

final Color defaultProgressBarColor = Colors.grey.shade400;

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

const wordDetailTitleStyle = TextStyle(fontSize: 30);
final wordDetailContentStyle = TextStyle(fontSize: 25, color: Colors.grey.shade600);

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
