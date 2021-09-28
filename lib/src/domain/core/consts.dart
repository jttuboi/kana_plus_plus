import 'dart:io';

class App {
  App._();

  static const String title = 'Kana++';
  static const String version = '1.0.0'; // sandbox mudar a versão do app aqui. procurar como deixar automático.

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

String get interstitialAdUnitId {
  if (Platform.isAndroid) {
    //return 'ca-app-pub-3940256099942544/1033173712'; // interstitial image
    return 'ca-app-pub-3940256099942544/8691691433'; // interstitial video
  } else if (Platform.isIOS) {
    return 'interstitial IOS UNIT ID';
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}

String toLanguageText(String localeCode) {
  if (localeCode == 'es') {
    return 'Español';
  } else if (localeCode == 'pt') {
    return 'Português brasileiro';
  }
  return 'English';
}
