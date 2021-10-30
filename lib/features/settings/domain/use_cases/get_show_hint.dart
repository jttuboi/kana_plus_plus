import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class GetShowHint implements UseCase<bool, NoParams> {
  GetShowHint(this.showHintRepository);

  final IShowHintRepository showHintRepository;

  @override
  Future<bool> call(NoParams params) async {
    return showHintRepository.getShowHint();
  }
}
