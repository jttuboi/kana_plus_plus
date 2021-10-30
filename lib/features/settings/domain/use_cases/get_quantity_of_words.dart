import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class GetQuantityOfWords implements UseCase<int, NoParams> {
  GetQuantityOfWords(this.quantityOfWordsRepository);

  final IQuantityOfWordsRepository quantityOfWordsRepository;

  @override
  Future<int> call(NoParams params) async {
    return quantityOfWordsRepository.getQuantityOfWords();
  }
}
