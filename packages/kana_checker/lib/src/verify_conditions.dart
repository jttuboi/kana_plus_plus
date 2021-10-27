import 'package:logger/logger.dart';

class VerifyConditions {
  VerifyConditions(double percentageToApprove) : _percentageToApprove = percentageToApprove;

  final double _percentageToApprove;

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
    var count = 0.0;
    for (final pointChecked in pointsChecked) {
      if (pointChecked) {
        count++;
      }
    }
    final approveUserPercentage = count / pointsChecked.length.toDouble();
    Logger().i('approve percentage -> $approveUserPercentage >= $_percentageToApprove <- percentage to approve');
    return approveUserPercentage >= _percentageToApprove;
  }
}
