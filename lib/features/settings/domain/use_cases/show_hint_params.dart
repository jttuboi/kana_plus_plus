import 'package:kwriting/core/core.dart';

class ShowHintParams extends Params {
  ShowHintParams(this.showHint);

  final bool showHint;

  @override
  List<Object?> get props => [showHint];
}
