import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:introduction_screen/introduction_screen.dart';

const defaultTitleFontFamily = 'Permanent Marker';
const defaultFontFamily = 'PT Sans';
const japaneseFontFamily = 'M PLUS Rounded 1c';

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

final TextStyle sliverFlexibleAppBarTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: Device.get().isTablet ? 56 : 40,
  fontFamily: defaultTitleFontFamily,
);

double appBarExpandedHeight(BuildContext context) {
  return MediaQuery.of(context).size.height * 1 / 5;
}

const Color defaultTileIconColor = Colors.grey;
const double defaultTileIconSize = 40;

final menuTitleTextStyle = TextStyle(
  color: Colors.white,
  fontSize: Device.get().isTablet ? 160 : 100,
  fontWeight: FontWeight.w700,
  fontFamily: defaultTitleFontFamily,
);

final menuGridButtonsSpacing = Device.get().isTablet ? 32.0 : 16.0;
final menuPadding = Device.get().isTablet ? const EdgeInsets.symmetric(horizontal: 96.0) : const EdgeInsets.symmetric(horizontal: 24.0);

final menuButtonIconSize = Device.get().isTablet ? 140.0 : 70.0;
final menuButtonIconColor = Colors.grey.shade200;

final menuButtonTextStyle = TextStyle(
  color: menuButtonIconColor,
  fontSize: Device.get().isTablet ? 50 : 28,
  fontFamily: defaultTitleFontFamily,
);

final menuExtraButtonIconSize = Device.get().isTablet ? 80.0 : 48.0;
final menuExtraButtonTitleSize = Device.get().isTablet ? 26.0 : 16.0;

final menuBackgroundBackPaint = Paint()..color = Colors.deepPurple.shade200;

final menuBackgroundMiddlePaint = Paint()..color = Colors.deepPurple.shade400;

final menuBackgroundMiddleBlurPaint = Paint()
  ..color = Colors.black87
  ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);

final menuBackgroundFrontPaint = Paint()..color = darkPurple;

final menuBackgroundFrontBlurPaint = Paint()
  ..color = Colors.black87
  ..maskFilter = const MaskFilter.blur(BlurStyle.outer, 10);

final introductionImageSize = Device.get().isTablet ? Device.screenWidth * 1 / 2 : Device.screenWidth * 2 / 3;

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
    fontSize: Device.get().isTablet ? 40.0 : 28.0,
    fontWeight: FontWeight.bold,
    fontFamily: defaultTitleFontFamily,
    color: Colors.grey.shade200,
    letterSpacing: 2.0,
  ),
  bodyTextStyle: TextStyle(
    fontSize: Device.get().isTablet ? 32.0 : 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.grey.shade200,
  ),
  descriptionPadding: const EdgeInsets.all(16.0).copyWith(bottom: 0.0),
  imagePadding: const EdgeInsets.all(24),
);

final introductionButtonTextStyle = TextStyle(
  fontSize: Device.get().isTablet ? 29.0 : 17.0,
  letterSpacing: 1.0,
  fontWeight: FontWeight.bold,
);
final introductionButtonStyle = ButtonStyle(
  padding: Device.get().isTablet ? MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16.0, horizontal: 26.0)) : null,
  backgroundColor: MaterialStateProperty.all(darkPurple),
);

final studyTitleFontSize = Device.get().isTablet ? 28.0 : 18.0;
final studyTextFontSize = Device.get().isTablet ? 24.0 : 16.0;
final studyTableTextFontSize = Device.get().isTablet ? 24.0 : 18.0;

final studyTitleTextStyle = TextStyle(fontSize: studyTitleFontSize, fontWeight: FontWeight.bold);
final studyTextStyleText = TextStyle(fontSize: studyTextFontSize);

final studyTableDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(8.0),
  color: Colors.deepPurple,
);
final studyTableTitleTextStyle = TextStyle(color: studyTableTitleColor, fontSize: studyTableTextFontSize);
final studyTableTitleColor = Colors.grey.shade300;

final studyTableRowDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(4.0),
  color: Colors.grey.shade50,
);
const studyTableRowHeight = 64.0;

const studyTableContentKanaTextStyle = TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
final studyTableContentRomajiTextStyle = TextStyle(fontSize: studyTableTextFontSize);
final studyTableContentButtonStyle = ButtonStyle(
  fixedSize: MaterialStateProperty.all(const Size(64.0, 64.0)),
  minimumSize: MaterialStateProperty.all(const Size(64.0, 64.0)),
  maximumSize: MaterialStateProperty.all(const Size(64.0, 64.0)),
  backgroundColor: MaterialStateProperty.all(Colors.grey.shade50),
  overlayColor: MaterialStateProperty.all(Colors.transparent),
);

final preTrainingPlayIconThemeData = IconThemeData(
  color: Colors.grey.shade300,
  size: 40.0,
);

final defaultProgressBarColor = Colors.grey.shade400;
final stepProgressIndicatorSize = Device.get().isTablet ? 6.0 : 5.0;

final correctBorderColor = Colors.blueAccent;
final wrongBorderColor = Colors.redAccent;
final defaultBorderColor = Colors.grey.shade500;

final writerButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white),
  overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
  side: MaterialStateBorderSide.resolveWith((states) => BorderSide(color: Colors.grey, width: Device.get().isTablet ? 2 : 1)),
  animationDuration: const Duration(milliseconds: 50),
  enableFeedback: false,
);
final writerIconButtonColor = Colors.grey.shade700;
final writerIconButtonSize = Device.get().isTablet ? 56.0 : 32.0;
final writerBorderWidth = Device.get().isTablet ? 15.0 : 9.0;

final kanaViewersViewpoertFraction = Device.get().isTablet ? 0.2 : 0.255;
final kanaViewerBorderWidth = Device.get().isTablet ? 8.0 : 4.0;

final romajiVieverTextStyle = TextStyle(
  color: const Color(0xff4d4d4d),
  fontSize: romajiViewerFontSize,
  fontFamily: defaultFontFamily,
  fontWeight: FontWeight.bold,
);
final romajiViewerFontSize = Device.get().isTablet ? 80.0 : 50.0;

final allStrokesPaint = Paint()
  ..isAntiAlias = true
  ..strokeWidth = Device.get().isTablet ? 22.0 : 14.0
  ..strokeCap = StrokeCap.round
  ..strokeJoin = StrokeJoin.round
  ..color = Colors.black;

final drawingStrokePaint = Paint()
  ..isAntiAlias = true
  ..strokeWidth = Device.get().isTablet ? 26.0 : 18.0
  ..strokeCap = StrokeCap.round
  ..strokeJoin = StrokeJoin.round
  ..color = Colors.black87;

final userStrokesPaint = Paint()
  ..isAntiAlias = true
  ..strokeWidth = Device.get().isTablet ? 9.0 : 5.0
  ..strokeCap = StrokeCap.round
  ..strokeJoin = StrokeJoin.round
  ..color = Colors.black;

const reviewTileTitleStyle = TextStyle(fontWeight: FontWeight.bold);

final wordDetailPadding = Device.get().isTablet ? const EdgeInsets.symmetric(horizontal: 36.0) : const EdgeInsets.symmetric(horizontal: 24.0);
final wordDetailTitleStyle = TextStyle(fontSize: Device.get().isTablet ? 48 : 30);
final wordDetailContentStyle = TextStyle(fontSize: Device.get().isTablet ? 40 : 25, color: Colors.grey.shade600);

final kanaDetailHeight = Device.get().isTablet ? 80.0 : 40.0;
final kanaDetailSpaceBetweenKanas = Device.get().isTablet ? 6.0 : 2.0;

final aboutImageSize = Device.screenWidth * 1 / 3;
final aboutFontSize = Device.get().isTablet ? 28.0 : 20.0;
final aboutAppVersionTitleTextStyle = TextStyle(fontSize: aboutFontSize, fontWeight: FontWeight.bold);
final aboutAppVersionTextStyle = TextStyle(fontSize: aboutFontSize);
final aboutDeveloperTitleTextStyle = TextStyle(fontSize: aboutFontSize, fontWeight: FontWeight.bold);
final aboutDeveloperTextStyle = TextStyle(fontSize: aboutFontSize);
final aboutIconSize = Device.get().isTablet ? 84.0 : 56.0;
final aboutTitleSize = Device.get().isTablet ? 28.0 : 18.0;
final aboutContactTextStyle = TextStyle(fontSize: aboutFontSize, color: Colors.blue, decoration: TextDecoration.underline);
final aboutIconTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: Colors.deepPurple.withOpacity(0.8),
);
