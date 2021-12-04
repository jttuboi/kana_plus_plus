import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/infra/infra.dart';
import 'package:kwriting/presentation/menu/menu.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:mocktail/mocktail.dart';

class MockDatabase extends Mock implements IDatabase {}

class MockStorage extends Mock implements IStorage {}

class MockAppRepository extends Mock implements IAppRepository {}

class MockKanaTypeRepository extends Mock implements IKanaTypeRepository {}

class MockLanguageRepository extends Mock implements ILanguageRepository {}

class MockQuantityOfWordsRepository extends Mock implements IQuantityOfWordsRepository {}

class MockShowHintRepository extends Mock implements IShowHintRepository {}

class MockAppCubit extends MockCubit<AppState> implements AppCubit {}

class MockKanaTypeChangeNotifier extends Mock implements KanaTypeChangeNotifier {}

class MockQuantityOfWordsChangeNotifier extends Mock implements QuantityOfWordsChangeNotifier {}

class MockShowHintChangeNotifier extends Mock implements ShowHintChangeNotifier {}

class MockInfoGetter extends Mock implements InfoGetter {}

class MockRateLauncher extends Mock implements RateLauncher {}

class MockShareLauncher extends Mock implements ShareLauncher {}

class MockUrlLauncher extends Mock implements UrlLauncher {}

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
