import 'package:kwriting/core/core.dart';

class QuantityOfWordsParams extends Params {
  QuantityOfWordsParams(this.quantityOfWords);

  final int quantityOfWords;

  @override
  List<Object?> get props => [quantityOfWords];
}
