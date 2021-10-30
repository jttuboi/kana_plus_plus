import 'package:flutter/widgets.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class WritingHandChangeNotifier extends ChangeNotifier {
  WritingHandChangeNotifier(IWritingHandRepository writingHandRepository) {
    _getWritingHand = GetWritingHand(writingHandRepository);
    _updateWritingHand = UpdateWritingHand(writingHandRepository);

    _getWritingHand(NoParams()).then((writingHand) {
      data = WritingHandData(writingHand: writingHand, iconUrl: _findIconUrl(writingHand));
      notifyListeners();
    });
  }

  late final GetWritingHand _getWritingHand;
  late final UpdateWritingHand _updateWritingHand;

  WritingHandData data = WritingHandData.empty;

  List<WritingHandData> get writingHandsData => [
        const WritingHandData(writingHand: WritingHand.left, iconUrl: IconUrl.writingHandLeft),
        const WritingHandData(writingHand: WritingHand.right, iconUrl: IconUrl.writingHandRight),
      ];

  void updateWritingHand(WritingHand writingHand) {
    data = WritingHandData(writingHand: writingHand, iconUrl: _findIconUrl(writingHand));
    _updateWritingHand(WritingHandParams(writingHand));
    notifyListeners();
  }

  String _findIconUrl(WritingHand writingHand) {
    return writingHandsData.firstWhere((data) => data.writingHand.equal(writingHand)).iconUrl;
  }
}
