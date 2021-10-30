import 'package:equatable/equatable.dart';
import 'package:kwriting/core/core.dart';

class ShowHintData extends Equatable {
  const ShowHintData({required this.showHint, required this.iconUrl});

  static const empty = ShowHintData(showHint: true, iconUrl: IconUrl.empty);

  final bool showHint;
  final String iconUrl;

  @override
  List<Object?> get props => [showHint, iconUrl];

  @override
  String toString() {
    return 'ShowHintData($showHint, $iconUrl)';
  }
}
