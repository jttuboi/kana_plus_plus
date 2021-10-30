import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class UpdateWritingHand implements UseCase<void, WritingHandParams> {
  UpdateWritingHand(this.writingHandRepository);

  final IWritingHandRepository writingHandRepository;

  @override
  Future<void> call(WritingHandParams params) async {
    await writingHandRepository.updateWritingHand(params.writingHand);
  }
}
