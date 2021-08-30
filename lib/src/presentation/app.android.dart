import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:kana_plus_plus/src/data/singletons/cache.dart';
import 'package:kana_plus_plus/src/data/repositories/dark_theme.repository.dart';
import 'package:kana_plus_plus/src/data/repositories/kana_type.repository.dart';
import 'package:kana_plus_plus/src/data/repositories/language.repository.dart';
import 'package:kana_plus_plus/src/data/repositories/quantity_of_words.repository.dart';
import 'package:kana_plus_plus/src/data/repositories/show_hint.repository.dart';
import 'package:kana_plus_plus/src/data/repositories/word.repository.dart';
import 'package:kana_plus_plus/src/data/repositories/writing_hand.repository.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/domain/usecases/pre_training.controller.dart';
import 'package:kana_plus_plus/src/domain/usecases/review.controller.dart';
import 'package:kana_plus_plus/src/domain/usecases/settings.controller.dart';
import 'package:kana_plus_plus/src/domain/usecases/training.controller.dart';
import 'package:kana_plus_plus/src/domain/usecases/words.controller.dart';
import 'package:kana_plus_plus/src/domain/usecases/writer.controller.dart';
import 'package:kana_plus_plus/src/presentation/arguments/training_arguments.dart';
import 'package:kana_plus_plus/src/presentation/arguments/words.arguments.dart';
import 'package:kana_plus_plus/src/presentation/arguments/pre_training_arguments.dart';
import 'package:kana_plus_plus/src/presentation/pages/menu.page.android.dart';
import 'package:kana_plus_plus/src/presentation/pages/settings.page.android.dart';
import 'package:kana_plus_plus/src/presentation/pages/word_detail.page.android.dart';
import 'package:kana_plus_plus/src/presentation/pages/words.page.android.dart';
import 'package:kana_plus_plus/src/presentation/state_management/writer.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/locale.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/review.state_management.dart';
import 'package:kana_plus_plus/src/presentation/state_management/theme.provider.dart';
import 'package:kana_plus_plus/src/presentation/state_management/training.state_management.dart';
import 'package:kana_plus_plus/src/presentation/state_management/training_kana_state_management.dart';
import 'package:kana_plus_plus/src/presentation/state_management/training_word.state_management.dart';
import 'package:kana_plus_plus/src/presentation/utils/routes.dart';
import 'package:kana_plus_plus/src/presentation/pages/pre_training.page.android.dart';
import 'package:kana_plus_plus/src/views/android/pages/kana.page.dart';
import 'package:kana_plus_plus/src/presentation/pages/review.page.android.dart';
import 'package:kana_plus_plus/src/views/android/pages/study.page.dart';
import 'package:kana_plus_plus/src/presentation/pages/training.page.android.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

class AndroidApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _providers,
      child: Consumer<ThemeProvider>(builder: (context, value, child) {
        return Consumer<LocaleProvider>(builder: (context, value, child) {
          return MaterialApp(
            title: appTitle,
            // TODO remover antes de dar deploy
            debugShowCheckedModeBanner: false,
            localizationsDelegates: _localizationsDelegates,
            supportedLocales: _supportedLocales,
            locale: _locale(context),
            themeMode: _themeMode(context),
            theme: _theme,
            darkTheme: _darkTheme,
            routes: _routes,
            onGenerateRoute: _onGenerateRoute,
          );
        });
      }),
    );
  }

  List<SingleChildWidget> get _providers {
    return [
      ChangeNotifierProvider(create: (context) {
        return ThemeProvider(Cache.getBool('dark_theme'));
      }),
      ChangeNotifierProvider(create: (context) {
        return LocaleProvider();
      }),
    ];
  }

  List<LocalizationsDelegate<dynamic>> get _localizationsDelegates {
    return const [
      ...JStrings.localizationsDelegates,
      LocaleNamesLocalizationsDelegate(),
    ];
  }

  List<Locale> get _supportedLocales => JStrings.supportedLocales;

  Locale _locale(BuildContext context) {
    return Provider.of<LocaleProvider>(context).locale;
  }

  ThemeMode _themeMode(BuildContext context) {
    return Provider.of<ThemeProvider>(context).mode;
  }

  ThemeData get _theme {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
    );
  }

  ThemeData get _darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primarySwatch: Colors.indigo,
    );
  }

  Map<String, WidgetBuilder> get _routes {
    return {
      Routes.menu: (context) => const MenuPage(),
      Routes.study: (context) => const StudyPage(),
      Routes.kana: (context) => const KanaPage(),
      Routes.preTraining: (context) => PreTrainingPage(
            PreTrainingController(
              showHintRepository: ShowHintRepository(),
              kanaTypeRepository: KanaTypeRepository(),
              quantityOfWordsRepository: QuantityOfWordsRepository(),
            ),
          ),
      Routes.words: (context) => WordsPage(
            WordsController(
              wordRepository: WordRepository(),
            ),
          ),
      Routes.settings: (context) => SettingsPage(
            SettingsController(
              languageRepository: LanguageRepository(),
              writingHandRepository: WritingHandRepository(),
              showHintRepository: ShowHintRepository(),
              darkThemeRepository: DarkThemeRepository(),
              kanaTypeRepository: KanaTypeRepository(),
              quantityOfWordsRepository: QuantityOfWordsRepository(),
            ),
          ),
    };
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.training) {
      final args = settings.arguments! as PreTrainingArguments;
      return MaterialPageRoute(
        builder: (context) {
          final trainingController = TrainingController(
            wordRepository: WordRepository(),
            kanaType: args.kanaType,
            quantityOfWords: args.quantityOfWords,
          );
          final writerController = WriterController(
            writingHandRepository: WritingHandRepository(),
            showHint: args.showHint,
          );
          return TrainingPage(
            trainingStateManagement: TrainingStateManagement(trainingController),
            wordStateManagement: TrainingWordStateManagement(trainingController),
            kanaStateManagement: TrainingKanaStateManagement(trainingController),
            writerProvider: WriterProvider(writerController),
            writerController: writerController,
          );
        },
      );
    } else if (settings.name == Routes.review) {
      final args = settings.arguments! as TrainingArguments;
      return MaterialPageRoute(
        builder: (context) => ReviewPage(
          reviewStateManagement: ReviewStateManagement(ReviewController()),
          wordsResult: args.wordsResult,
        ),
      );
    } else if (settings.name == Routes.word) {
      final args = settings.arguments! as WordsArguments;
      return MaterialPageRoute(
        builder: (context) => WordDetailPage(
          word: args.word,
        ),
      );
    }
  }
}
