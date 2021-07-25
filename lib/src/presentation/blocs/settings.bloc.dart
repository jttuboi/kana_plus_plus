import 'package:kana_plus_plus/src/domain/settings.controller.dart';
import 'package:kana_plus_plus/src/presentation/viewmodels/description.viewmodel.dart';

class SettingsBloc {
  SettingsBloc(this._controller);

  final SettingsController _controller;

  String get aboutIconUrl => "lib/assets/icons/black/about.png";
  String get privacyPolicyIconUrl =>
      "lib/assets/icons/black/privacy_policy.png";
  String get supportIconUrl => "lib/assets/icons/black/support.png";

  List<DescriptionViewModel> get aboutDescriptions => [];

  List<DescriptionViewModel> get privacyPolicyDescriptions => [];

///////////////////////ESSES DADOS DEVEM VIR DO BANCO DE DADOS NAO DO TRANSLATE.
  ///                 O LOCALE DEVE SER PASSADO PARA O BD E DE LÄ ELE RETORNA OS DADOS CORRETOS

  final List<DescriptionViewModel> _aboutDescriptions = [
    DescriptionViewModel.title("blablable"),
    DescriptionViewModel.content("informaçoes sobre mim"),
    DescriptionViewModel.content("contato"),
    DescriptionViewModel.content("de onde os dados vieram"),
  ];

  final List<DescriptionViewModel> _privacyPolicyDescriptions = [
    DescriptionViewModel.title("citar sobre uso"),
    DescriptionViewModel.content(
        "blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla blablabla"),
  ];
}
