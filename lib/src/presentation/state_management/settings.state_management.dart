import 'package:kana_plus_plus/src/data/models/description.model.dart';
import 'package:kana_plus_plus/src/domain/usecases/settings.controller.dart';

class SettingsStateManagement {
  SettingsStateManagement(this._controller);

  final SettingsController _controller;

  List<DescriptionModel> get aboutDescriptions => _controller.aboutDescriptions;

  List<DescriptionModel> get privacyPolicyDescriptions => _controller.privacyPolicyDescriptions;
}
