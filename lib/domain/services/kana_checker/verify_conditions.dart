import 'dart:developer';

class VerifyConditions {
  VerifyConditions(double percentageToApprove) : _percentageToApprove = percentageToApprove;

  final double _percentageToApprove;

  bool allDataStrokesChecked(List<bool> strokeChecked) {
    for (final pointChecked in strokeChecked) {
      if (!pointChecked) {
        log('all points checked -> false');
        return false;
      }
    }
    log('all points checked -> true');
    return true;
  }

  bool allUserPointsChecked(List<bool> pointsChecked) {
    var count = 0.0;
    for (final pointChecked in pointsChecked) {
      if (pointChecked) {
        count++;
      }
    }
    final approveUserPercentage = count / pointsChecked.length.toDouble();
    log('approve percentage -> $approveUserPercentage >= $_percentageToApprove <- percentage to approve');
    return approveUserPercentage >= _percentageToApprove;
  }
}
