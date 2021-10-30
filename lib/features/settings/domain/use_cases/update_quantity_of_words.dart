import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class UpdateQuantityOfWords implements UseCase<void, QuantityOfWordsParams> {
  UpdateQuantityOfWords(this.quantityOfWordsRepository);

  final IQuantityOfWordsRepository quantityOfWordsRepository;

  @override
  Future<void> call(QuantityOfWordsParams params) async {
    await quantityOfWordsRepository.updateQuantityOfWords(params.quantityOfWords);
  }
}
