import 'package:kwriting/core/core.dart';
import 'package:kwriting/features/settings/settings.dart';

class GetKanaType implements UseCase<KanaType, NoParams> {
  GetKanaType(this.kanaTypeRepository);

  final IKanaTypeRepository kanaTypeRepository;

  @override
  Future<KanaType> call(NoParams params) async {
    return kanaTypeRepository.getKanaType();
  }
}
