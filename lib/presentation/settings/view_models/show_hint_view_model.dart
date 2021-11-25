import 'package:equatable/equatable.dart';
import 'package:kwriting/core/core.dart';

class ShowHintViewModel extends Equatable {
  const ShowHintViewModel({required this.showHint, required this.iconUrl});

  static const empty = ShowHintViewModel(showHint: true, iconUrl: IconUrl.empty);

  final bool showHint;
  final String iconUrl;

  @override
  List<Object?> get props => [showHint, iconUrl];

  @override
  String toString() {
    return 'ShowHintData($showHint, $iconUrl)';
  }
}
