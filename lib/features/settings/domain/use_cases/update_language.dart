import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class UpdateLanguage implements UseCase<void, LanguageParams> {
  UpdateLanguage(this.languageRepository);

  final ILanguageRepository languageRepository;

  @override
  Future<void> call(LanguageParams params) async {
    await languageRepository.updateLanguage(params.localeCode);
  }
}
