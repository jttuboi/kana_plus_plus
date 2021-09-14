import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

abstract class IKanaChecker {
  Future<void> load();

  bool checkKana(String kana, List<List<Offset>> normalizedStrokes);
}

class KanaChecker implements IKanaChecker {
  KanaChecker({this.percentageToApprove = 0.8});

  @override
  Future<void> load() async {
    final response = await rootBundle.loadString('lib/assets/database/points.json');
    final jsonFile = json.decode(response) as Map<String, dynamic>;
    data = convertToData(jsonFile);
  }

  // TODO end - mudar as constantes antes de finalizar o app
  static const powRadius = 0.0225; // radius = 0.15 = 15% de 100 pixels
  final double percentageToApprove;

  late final Map<String, List<List<Offset>>> data;

  @override
  bool checkKana(String kana, List<List<Offset>> normalizedStrokes) {
    final dataStrokes = data[kana]!;
    final userStrokes = normalizedStrokes;

    // all points need to be true to approve
    final dataStrokesChecked = <List<bool>>[];
    for (final dataStroke in dataStrokes) {
      dataStrokesChecked.add(List<bool>.filled(dataStroke.length, false));
    }

    // 90% of all points need to be true to approve
    final userPointsChecked = <bool>[];

    // check if the user points is inside of data stroke
    for (int i = 0; i < userStrokes.length; i++) {
      final dataStroke = dataStrokes[i];
      final userStroke = userStrokes[i];
      final dataStrokeChecked = dataStrokesChecked[i];

      for (final userPoint in userStroke) {
        bool userPointAdded = false;
        for (int j = 0; j < dataStroke.length; j++) {
          final dataPoint = dataStroke[j];
          if (pow(dataPoint.dx - userPoint.dx, 2) + pow(dataPoint.dy - userPoint.dy, 2) <= powRadius) {
            if (!userPointAdded) {
              userPointsChecked.add(true);
              userPointAdded = true;
            }
            dataStrokeChecked[j] = true;
          }
        }
        if (!userPointAdded) {
          userPointsChecked.add(false);
        }
      }
    }

    // verify conditions
    return allDataStrokesChecked(dataStrokesChecked) && allUserPointsChecked(userPointsChecked);
  }

  bool allDataStrokesChecked(List<List<bool>> strokesChecked) {
    //print(strokesChecked);
    for (final strokeChecked in strokesChecked) {
      for (final pointChecked in strokeChecked) {
        if (!pointChecked) {
          Logger().i('all points checked -> false');
          return false;
        }
      }
    }
    Logger().i('all points checked -> true');
    return true;
  }

  bool allUserPointsChecked(List<bool> pointsChecked) {
    //print(pointsChecked);
    double count = 0.0;
    for (final pointChecked in pointsChecked) {
      if (pointChecked) {
        count++;
      }
    }
    final approveUserPercentage = count / pointsChecked.length.toDouble();
    Logger().i('approve percentage -> $approveUserPercentage >= $percentageToApprove <- percentage to approve');
    return approveUserPercentage >= percentageToApprove;
  }

  Map<String, List<List<Offset>>> convertToData(Map<String, dynamic> jsonFile) {
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


// final tuple = _isUserPointInsideDataStroke(userPoint, dataStroke);
// final isInside = tuple[0] as bool;
// final indexDataPoint = tuple[1] as int;
// userPointsChecked.add(isInside);
// if (indexDataPoint != -1) {
//   dataStrokeChecked[indexDataPoint] = isInside;
// }

// // tuple[0] is bool represented for if user point is inside of data source.
// // tuple[1] is in represented for index of data point is checked. if doesn't have, return -1.
// List<dynamic> _isUserPointInsideDataStroke(Offset userPoint, List<Offset> dataStroke) {
//   for (int j = 0; j < dataStroke.length; j++) {
//     final dataPoint = dataStroke[j];
//     if (pow(dataPoint.dx - userPoint.dx, 2) + pow(dataPoint.dy - userPoint.dy, 2) <= powRadius) {
//       return [true, j];
//     }
//   }
//   return [false, -1];
// }
