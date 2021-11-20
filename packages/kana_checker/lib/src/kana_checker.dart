import 'dart:math';
import 'package:kana_checker/src/points_data.dart';
import 'package:kana_checker/src/verify_conditions.dart';

class KanaChecker {
  KanaChecker({
    double percentageToApprove = 0.8,
    double percentageRadius = 0.15, // radius = 0.15 = 15% de 100 pixels
  })  : _powRadius = pow(percentageRadius, 2).toDouble(),
        _verifyConditions = VerifyConditions(percentageToApprove);

  final double _powRadius;
  final VerifyConditions _verifyConditions;
  late final Map<String, List<List<Point<double>>>> _data;

  Future<void> initialize() async {
    _data = await PointsData().preloadData();
  }

  bool checkKana(String kana, List<List<Point<double>>> normalizedStrokes) {
    final dataStrokes = _data[kana]!;
    final userStrokes = normalizedStrokes;

    // all points need to be true to approve
    final dataStrokesChecked = <List<bool>>[];
    for (final dataStroke in dataStrokes) {
      dataStrokesChecked.add(List<bool>.filled(dataStroke.length, false));
    }

    // 90% of all points need to be true to approve
    final userPointsChecked = <bool>[];

    // check if the user points is inside of data stroke
    for (var i = 0; i < userStrokes.length; i++) {
      final dataStroke = dataStrokes[i];
      final userStroke = userStrokes[i];
      final dataStrokeChecked = dataStrokesChecked[i];

      for (final userPoint in userStroke) {
        var userPointAdded = false;
        for (var j = 0; j < dataStroke.length; j++) {
          final dataPoint = dataStroke[j];
          if (pow(dataPoint.x - userPoint.x, 2) + pow(dataPoint.y - userPoint.y, 2) <= _powRadius) {
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

    return _verifyConditions.allDataStrokesChecked(dataStrokesChecked) && _verifyConditions.allUserPointsChecked(userPointsChecked);
  }
}
