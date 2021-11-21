import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/menu/menu.dart';

class IsFirstTime implements UseCase<bool, NoParams> {
  IsFirstTime(this.appRepository);

  final IAppRepository appRepository;

  @override
  Future<bool> call(NoParams params) async {
    return appRepository.isFirstTime();
  }
}
