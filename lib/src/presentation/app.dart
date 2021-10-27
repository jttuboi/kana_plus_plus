import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_checker/kana_checker.dart';
import 'package:provider/provider.dart';
import 'package:stroke_reducer/stroke_reducer.dart';
import 'package:kwriting/src/domain/controllers/app.controller.dart';
import 'package:kwriting/src/domain/controllers/pre_training.controller.dart';
import 'package:kwriting/src/domain/controllers/review.controller.dart';
import 'package:kwriting/src/domain/controllers/settings.controller.dart';
import 'package:kwriting/src/domain/controllers/training.controller.dart';
import 'package:kwriting/src/domain/controllers/words.controller.dart';
import 'package:kwriting/src/domain/controllers/writer.controller.dart';
import 'package:kwriting/src/domain/utils/consts.dart';
import 'package:kwriting/src/infrastructure/repositories/app.repository.dart';
import 'package:kwriting/src/infrastructure/repositories/dark_theme.repository.dart';
import 'package:kwriting/src/infrastructure/repositories/kana_type.repository.dart';
import 'package:kwriting/src/infrastructure/repositories/language.repository.dart';
import 'package:kwriting/src/infrastructure/repositories/quantity_of_words.repository.dart';
import 'package:kwriting/src/infrastructure/repositories/show_hint.repository.dart';
import 'package:kwriting/src/infrastructure/repositories/statistics.repository.dart';
import 'package:kwriting/src/infrastructure/repositories/word.repository.dart';
import 'package:kwriting/src/infrastructure/repositories/writing_hand.repository.dart';
import 'package:kwriting/src/infrastructure/singletons/database.dart';
import 'package:kwriting/src/infrastructure/utils/consts.dart';
import 'package:kwriting/src/presentation/arguments/pre_training_arguments.dart';
import 'package:kwriting/src/presentation/arguments/training_arguments.dart';
import 'package:kwriting/src/presentation/arguments/words.arguments.dart';
import 'package:kwriting/src/presentation/pages/about.page.android.dart';
import 'package:kwriting/src/presentation/pages/menu.page.android.dart';
import 'package:kwriting/src/presentation/pages/pre_training.page.android.dart';
import 'package:kwriting/src/presentation/pages/review.page.android.dart';
import 'package:kwriting/src/presentation/pages/settings.page.android.dart';
import 'package:kwriting/src/presentation/pages/study.page.android.dart';
import 'package:kwriting/src/presentation/pages/training.page.android.dart';
import 'package:kwriting/src/presentation/pages/word_detail.page.android.dart';
import 'package:kwriting/src/presentation/pages/words.page.android.dart';
import 'package:kwriting/src/presentation/state_management/locale.provider.dart';
import 'package:kwriting/src/presentation/state_management/theme.provider.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:kwriting/src/presentation/utils/routes.dart';

class AndroidApp extends StatelessWidget {
  final appController = AppController(appRepository: AppRepository(), languageRepository: LanguageRepository());

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider(Database.getBool(DatabaseTag.darkTheme))),
        ChangeNotifierProvider(create: (context) => LocaleProvider(appController)),
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return Consumer<LocaleProvider>(builder: (context, localeProvider, child) {
          return MaterialApp(
            title: App.title,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: JStrings.localizationsDelegates,
            supportedLocales: JStrings.supportedLocales,
            themeMode: ThemeMode.light, //themeProvider.mode,
            locale: _locale(localeProvider),
            localeResolutionCallback: _localeResolutionCallback,
            theme: lightTheme,
            //darkTheme: darkTheme,
            routes: _routes,
            onGenerateRoute: _onGenerateRoute,
          );
        });
      }),
    );
  }

  Map<String, WidgetBuilder> get _routes => {
        Routes.menu: (context) => MenuPage(appController),
        Routes.study: (context) => const StudyPage(),
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
        Routes.about: (context) => const AboutPage(),
      };

  Locale? _locale(LocaleProvider localeProvider) {
    return (appController.isFirstTime) ? null : localeProvider.locale;
  }

  Locale? _localeResolutionCallback(Locale? locale, Iterable<Locale>? supportedLocales) {
    // locale is from device. it is the current device language used.
    // supportedLocales are the languages supported of this app.
    appController.setDeviceLocale(locale);
    return appController.locale;
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    if (settings.name == Routes.training) {
      final args = settings.arguments! as PreTrainingArguments;
      return MaterialPageRoute(
        builder: (context) {
          final kanaChecker = KanaChecker();
          return TrainingPage(
            trainingController: TrainingController(
              wordRepository: WordRepository(),
              statisticsRepository: StatisticsRepository(),
              kanaChecker: kanaChecker,
              showHint: args.showHint,
              kanaType: args.kanaType,
              quantityOfWords: args.quantityOfWords,
            ),
            writerController: WriterController(
              writingHandRepository: WritingHandRepository(),
              strokeReducer: StrokeReducer(minPointsQuantity: 20),
              kanaChecker: kanaChecker,
              showHint: args.showHint,
            ),
          );
        },
      );
    } else if (settings.name == Routes.review) {
      final args = settings.arguments! as TrainingArguments;
      return MaterialPageRoute(
        builder: (context) => ReviewPage(
          reviewController: ReviewController(
            statisticsRepository: StatisticsRepository(),
          ),
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
