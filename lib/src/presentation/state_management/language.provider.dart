import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/domain/repositories/settings.interface.dart';
import 'package:kana_plus_plus/src/presentation/arguments/selection_option.arguments.dart';

class LanguageProvider extends ChangeNotifier {
  LanguageProvider(this._repository) {
    selectedKey = _repository.getLanguageSelected();
    notifyListeners();
  }

  final ISettingsRepository _repository;
  final List<String> _ignoreLocaleCodes = ["pt"];

  late String selectedKey;

  String get iconUrl => _repository.getLanguageIconUrl();

  String get text => _repository.getLanguageText(selectedKey);

  List<SelectionOptionArguments> get options {
    return JStrings.supportedLocales.where((Locale locale) {
      return !_ignoreLocaleCodes.contains(locale.toString());
    }).map((Locale locale) {
      return SelectionOptionArguments(
        key: locale.toString(),
        label: _repository.getLanguageText(locale.toString()),
      );
    }).toList();
  }

  void updateKey(String pSelectedKey) {
    selectedKey = pSelectedKey;
    _repository.saveLanguageSelected(pSelectedKey);
    notifyListeners();
  }
}
