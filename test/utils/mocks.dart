import 'package:bloc_test/bloc_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:kwriting/presentation/menu/menu.dart';
import 'package:mocktail/mocktail.dart';

class MockDatabase extends Mock implements IDatabase {}

class MockStorage extends Mock implements IStorage {}

class MockAppRepository extends Mock implements IAppRepository {}

class MockLanguageRepository extends Mock implements ILanguageRepository {}

class MockAppCubit extends MockCubit<AppState> implements AppCubit {}
