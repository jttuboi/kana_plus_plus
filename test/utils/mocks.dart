import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:kwriting/presentation/menu/menu.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:kwriting/presentation/words/words.dart';
import 'package:mocktail/mocktail.dart';

class MockDatabase extends Mock implements IDatabase {}

class MockStorage extends Mock implements IStorage {}

class MockAppRepository extends Mock implements IAppRepository {}

class MockKanaTypeRepository extends Mock implements IKanaTypeRepository {}

class MockLanguageRepository extends Mock implements ILanguageRepository {}

class MockQuantityOfWordsRepository extends Mock implements IQuantityOfWordsRepository {}

class MockShowHintRepository extends Mock implements IShowHintRepository {}

class MockWordsRepository extends Mock implements IWordsRepository {}

class MockStatisticsRepository extends Mock implements IStatisticsRepository {}

class MockAppCubit extends MockCubit<AppState> implements AppCubit {}

class MockWordsBloc extends MockBloc<WordsEvent, WordsState> implements WordsBloc {}

class MockListBloc extends MockBloc<ListEvent, ListState> implements ListBloc {}

class MockTrainingBloc extends MockBloc<TrainingEvent, TrainingState> implements TrainingBloc {}

class MockWordBloc extends MockBloc<WordEvent, WordState> implements WordBloc {}

class MockKanaBloc extends MockBloc<KanaEvent, KanaState> implements KanaBloc {}

class MockFilteredWordsBloc extends MockBloc<FilteredWordsEvent, FilteredWordsState> implements FilteredWordsBloc {}

class MockWriterBloc extends MockBloc<WriterEvent, WriterState> implements WriterBloc {}

class MockKanaTypeChangeNotifier extends Mock implements KanaTypeChangeNotifier {}

class MockQuantityOfWordsChangeNotifier extends Mock implements QuantityOfWordsChangeNotifier {}

class MockShowHintChangeNotifier extends Mock implements ShowHintChangeNotifier {}

class MockStrokeReducer extends Mock implements IStrokeReducer {}

class MockKanaChecker extends Mock implements IKanaChecker {}

class MockInfoGetter extends Mock implements IInfoGetter {}

class MockRateLauncher extends Mock implements IRateLauncher {}

class MockShareLauncher extends Mock implements IShareLauncher {}

class MockUrlLauncher extends Mock implements IUrlLauncher {}

class FakeSupportButton extends ISupportButton {
  const FakeSupportButton({Key? key}) : super(key: key);

  @override
  _FakeSupportButtonState createState() => _FakeSupportButtonState();
}

class _FakeSupportButtonState extends State<FakeSupportButton> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
