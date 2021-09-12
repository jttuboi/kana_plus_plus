class App {
  App._();

  static const String title = 'Kana++';
  static const String version = '1.0.0'; // TODO end - atualizar a versão aqui

  static const String playStoreUrl = 'https://play.google.com/store/apps/details?id=com.kana_plus_plus';
  static const String appStoreUrl = '';

  static const String androidId = 'com.kana_plus_plus';
  static const String iosId = '';

  static const String privacyPolicyUrl = 'https://tuboi-studios.github.io/kana_plus_plus_terms_of_use_and_privacy_policy';
}

class Developer {
  Developer._();

  static const String name = 'Jairo Toshio Tuboi';
  static const String contact = 'tuboi.studios@gmail.com';
}

class Default {
  Default._();

  static const String locale = 'en';
  static const int minimumTrainingCards = 5;
  static const int maximumTrainingCards = 20;
  static const bool showHint = true;
  static const bool firstTime = true;

  static const String contactSubject = 'Contact via Kana++';
  static const String emailSubject = 'Learn hiragana/katakana on Kana++';
}

String toLanguageText(String localeCode) {
  if (localeCode == 'es') {
    return 'Español';
  } else if (localeCode == 'pt') {
    return 'Português brasileiro';
  }
  return 'English';
}
