import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class GetLanguage implements UseCase<String, NoParams> {
  GetLanguage(this.languageRepository);

  final ILanguageRepository languageRepository;

  @override
  Future<String> call(NoParams params) async {
    return languageRepository.getLanguage();
  }
}
