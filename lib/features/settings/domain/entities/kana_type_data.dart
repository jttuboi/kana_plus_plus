import 'package:equatable/equatable.dart';
import 'package:kwriting/core/core.dart';

class KanaTypeData extends Equatable {
  const KanaTypeData({required this.kanaType, required this.iconUrl});

  static const empty = KanaTypeData(kanaType: KanaType.both, iconUrl: IconUrl.empty);

  final KanaType kanaType;
  final String iconUrl;

  @override
  List<Object?> get props => [kanaType, iconUrl];

  @override
  String toString() {
    return 'KanaTypeData($kanaType, $iconUrl)';
  }
}