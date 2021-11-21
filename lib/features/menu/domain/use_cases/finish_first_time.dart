import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/menu/menu.dart';

class FinishFirstTime implements UseCase<void, NoParams> {
  FinishFirstTime(this.appRepository);

  final IAppRepository appRepository;

  @override
  Future<void> call(NoParams params) async {
    await appRepository.setFirstTime(false);
  }
}
