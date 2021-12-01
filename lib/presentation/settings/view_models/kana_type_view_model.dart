import 'package:equatable/equatable.dart';
import 'package:kwriting/domain/domain.dart';

class KanaTypeViewModel extends Equatable {
  const KanaTypeViewModel({required this.kanaType, required this.iconUrl});

  static const empty = KanaTypeViewModel(kanaType: KanaType.both, iconUrl: IconUrl.empty);

  final KanaType kanaType;
  final String iconUrl;

  @override
  List<Object?> get props => [kanaType, iconUrl];

  @override
  String toString() {
    return 'KanaTypeData($kanaType, $iconUrl)';
  }
}
