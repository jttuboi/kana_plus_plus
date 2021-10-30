import 'package:kwriting/core/core.dart';

class KanaTypeParams extends Params {
  KanaTypeParams(this.kanaType);

  final KanaType kanaType;

  @override
  List<Object?> get props => [kanaType];
}
