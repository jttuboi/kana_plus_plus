import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class GetWritingHand implements UseCase<WritingHand, NoParams> {
  GetWritingHand(this.writingHandRepository);

  final IWritingHandRepository writingHandRepository;

  @override
  Future<WritingHand> call(NoParams params) async {
    return writingHandRepository.getWritingHand();
  }
}
