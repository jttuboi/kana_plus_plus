import 'package:kwriting/core/core.dart';

class WritingHandParams extends Params {
  WritingHandParams(this.writingHand);

  final WritingHand writingHand;

  @override
  List<Object?> get props => [writingHand];
}
