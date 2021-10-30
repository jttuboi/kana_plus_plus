import 'package:kwriting/core/core.dart';

class LanguageParams extends Params {
  LanguageParams(this.localeCode);

  final String localeCode;

  @override
  List<Object?> get props => [localeCode];
}
