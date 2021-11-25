import 'package:equatable/equatable.dart';
import 'package:kwriting/core/core.dart';

class WritingHandViewModel extends Equatable {
  const WritingHandViewModel({required this.writingHand, required this.iconUrl});

  static const empty = WritingHandViewModel(writingHand: WritingHand.right, iconUrl: IconUrl.empty);

  final WritingHand writingHand;
  final String iconUrl;

  @override
  List<Object?> get props => [writingHand, iconUrl];

  @override
  String toString() {
    return 'WritingHandData($writingHand, $iconUrl)';
  }
}
