import 'package:flutter/widgets.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/settings/settings.dart';

class WritingHandChangeNotifier extends ChangeNotifier {
  WritingHandChangeNotifier(this.writingHandRepository) {
    writingHandRepository.getWritingHand().then((writingHand) {
      data = WritingHandViewModel(writingHand: writingHand, iconUrl: _findIconUrl(writingHand));
      notifyListeners();
    });
  }

  final IWritingHandRepository writingHandRepository;

  WritingHandViewModel data = WritingHandViewModel.empty;

  List<WritingHandViewModel> get writingHandsData => [
        const WritingHandViewModel(writingHand: WritingHand.left, iconUrl: IconUrl.writingHandLeft),
        const WritingHandViewModel(writingHand: WritingHand.right, iconUrl: IconUrl.writingHandRight),
      ];

  void updateWritingHand(WritingHand writingHand) {
    data = WritingHandViewModel(writingHand: writingHand, iconUrl: _findIconUrl(writingHand));
    writingHandRepository.updateWritingHand(writingHand);
    notifyListeners();
  }

  String _findIconUrl(WritingHand writingHand) {
    return writingHandsData.firstWhere((data) => data.writingHand.equal(writingHand)).iconUrl;
  }
}
