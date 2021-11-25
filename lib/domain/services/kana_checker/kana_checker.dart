import 'package:flutter/material.dart';
import 'package:kwriting/domain/services/kana_checker/points_data.dart';
import 'package:kwriting/domain/services/kana_checker/verify_conditions.dart';

class KanaChecker {
  KanaChecker({
    double percentageToApprove = 0.8,
    double percentageRadius = 0.15, // radius = 0.15 = 15% de 100 pixels
  })  : assert(0 <= percentageToApprove && percentageToApprove <= 1, 'percentageToApprove must be percentageToApprove = [0, 1]'),
        assert(0 <= percentageRadius && percentageRadius <= 1, 'percentageRadius must be percentageToApprove = [0, 1]'),
        _powRadius = percentageRadius * percentageRadius,
        _verifyConditions = VerifyConditions(percentageToApprove),
        radiusComparisonSize = percentageRadius * 100;

  final double _powRadius;
  final VerifyConditions _verifyConditions;
  late final Map<String, List<List<Offset>>> _data;

  late final double radiusComparisonSize;

  Future<void> initialize() async {
    _data = await PointsData().preloadData();
  }

  bool checkKana(String kana, int strokeIndex, List<Offset> normalizedStroke) {
    final dataStroke = _data[kana]![strokeIndex];
    final userStroke = normalizedStroke;

    // all points need to be true to approve
    final dataStrokeChecked = List<bool>.filled(dataStroke.length, false);

    // 90% of all points need to be true to approve
    final userPointsChecked = <bool>[];

    // check if the user points is inside of data stroke
    for (final userPoint in userStroke) {
      var userPointAdded = false;
      for (var j = 0; j < dataStroke.length; j++) {
        final dataPoint = dataStroke[j];
        if ((dataPoint.dx - userPoint.dx) * (dataPoint.dx - userPoint.dx) + (dataPoint.dy - userPoint.dy) * (dataPoint.dy - userPoint.dy) <=
            _powRadius) {
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

    return _verifyConditions.allDataStrokesChecked(dataStrokeChecked) && _verifyConditions.allUserPointsChecked(userPointsChecked);
  }
}
