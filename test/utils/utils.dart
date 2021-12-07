import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExtension on WidgetTester {
  void expectSvgPicture(String assetName, {required int indexInWidgets}) {
    final svgPicture = widget<SvgPicture>(find.byType(SvgPicture).at(indexInWidgets));
    expect((svgPicture.pictureProvider as ExactAssetPicture).assetName, assetName);
  }

  void expectCustomPaintWith<T>({int painterQuantityExpected = 1}) {
    final paints = widgetList<CustomPaint>(find.byType(CustomPaint)).where((paint) => paint.painter is T).toList();
    expect(paints.length, painterQuantityExpected);
  }

  void expectWidget<T>({int widgetQuantityExpected = 1}) {
    expect(find.byType(T), findsNWidgets(widgetQuantityExpected));
  }

  void expectText(String text, {int textQuantityExpected = 1}) {
    expect(find.text(text), findsNWidgets(textQuantityExpected));
  }
}
