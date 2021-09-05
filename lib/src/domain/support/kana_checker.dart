import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/services.dart';

class KanaChecker {
  Future<void> load() async {
    return rootBundle.loadString('lib/assets/database/points.json').then((response) {
      final jsonFile = json.decode(response) as Map<String, dynamic>;
      data = _convertToData(jsonFile);
    });
  }

  static const powRadius = 0.0225; // radius = 0.15 = 15% de 100 pixels
  static const percentageToApprove = 0.65; // 65%

  late final Map<String, List<List<Offset>>> data;

  bool checkKana(String kana, List<List<Offset>> normalizedStrokes) {
    final oks = <bool>[];
    final strokesData = data[kana];

    //print('user = $normalizedStrokes');
    //print('data = $strokesData');

    for (int strokeIdx = 0; strokeIdx < normalizedStrokes.length; strokeIdx++) {
      final strokeToCheck = normalizedStrokes[strokeIdx];
      for (int pointIdx = 0; pointIdx < strokeToCheck.length; pointIdx++) {
        final pointToCheck = strokeToCheck[pointIdx];
        oks.add(_isInside(pointToCheck, strokesData![strokeIdx]));
      }
    }
    return _isOk(oks);
  }

  bool _isInside(Offset pointToCheck, List<Offset> strokeData) {
    //print('check (${pointToCheck.dx}, ${pointToCheck.dy})');
    for (int pointIdx = 0; pointIdx < strokeData.length; pointIdx++) {
      //print('data[$pointIdx] (${strokeData[pointIdx].dx}, ${strokeData[pointIdx].dy})');
      if (pow(strokeData[pointIdx].dx - pointToCheck.dx, 2) + pow(strokeData[pointIdx].dy - pointToCheck.dy, 2) <= powRadius) {
        return true;
      }
    }
    return false;
  }

  bool _isOk(List<bool> oks) {
    double count = 0.0;
    for (final ok in oks) {
      if (ok) {
        count++;
      }
    }
    final approveUserPercentage = count / oks.length.toDouble();
    // ignore: avoid_print
    print('approve percentage = $approveUserPercentage');
    return approveUserPercentage >= percentageToApprove;
  }

  Map<String, List<List<Offset>>> _convertToData(Map<String, dynamic> jsonFile) {
    return jsonFile.map((key, value) {
      final strokes = value as List<dynamic>;
      final newStrokes = <List<Offset>>[];
      for (final stroke in strokes) {
        final points = stroke as List<dynamic>;
        final newPoints = <Offset>[];
        for (final point in points) {
          newPoints.add(Offset(point['x'] as double, point['y'] as double));
        }
        newStrokes.add(newPoints);
      }
      return MapEntry(key, newStrokes);
    });
  }
}
