import 'package:kana_plus_plus/src/data/models/description.model.dart';
import 'package:kana_plus_plus/src/domain/usecases/settings.controller.dart';

class SettingsStateManagement {
  SettingsStateManagement(this._controller);

  final SettingsController _controller;

  String get aboutIconUrl => _controller.getAboutIconUrl();

  String get privacyPolicyIconUrl => _controller.getPrivacyPolicyIconUrl();

  String get supportIconUrl => _controller.getSupportIconUrl();

  List<DescriptionModel> get aboutDescriptions =>
      _controller.getAboutDescriptions();

  List<DescriptionModel> get privacyPolicyDescriptions =>
      _controller.getPrivacyPolicyDescriptions();
}
