import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class UpdateShowHint implements UseCase<void, ShowHintParams> {
  UpdateShowHint(this.showHintRepository);

  final IShowHintRepository showHintRepository;

  @override
  Future<void> call(ShowHintParams params) async {
    await showHintRepository.updateShowHint(params.showHint);
  }
}
