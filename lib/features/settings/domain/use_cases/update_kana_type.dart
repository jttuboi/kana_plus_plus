import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class UpdateKanaType implements UseCase<void, KanaTypeParams> {
  UpdateKanaType(this.kanaTypeRepository);

  final IKanaTypeRepository kanaTypeRepository;

  @override
  Future<void> call(KanaTypeParams params) async {
    await kanaTypeRepository.updateKanaType(params.kanaType);
  }
}
