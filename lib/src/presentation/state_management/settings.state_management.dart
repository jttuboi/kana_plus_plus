import 'package:kana_plus_plus/src/domain/repositories/settings.interface.dart';
import 'package:kana_plus_plus/src/data/models/description.model.dart';

class SettingsStateManagement {
  SettingsStateManagement(this._repository);

  final ISettingsRepository _repository;

  String get aboutIconUrl => _repository.getAboutIconUrl();
  String get privacyPolicyIconUrl => _repository.getPrivacyPolicyIconUrl();

  String get supportIconUrl => _repository.getSupportIconUrl();

  List<DescriptionModel> get aboutDescriptions =>
      _repository.getAboutDescriptions();

  List<DescriptionModel> get privacyPolicyDescriptions =>
      _repository.getPrivacyPolicyDescriptions();
}
