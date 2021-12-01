import 'package:kwriting/presentation/shared/shared.dart';

class SelectionOptionArgs {
  SelectionOptionArgs({
    required this.title,
    required this.bannerUrl,
    required this.selectedOptionKey,
    required this.options,
    required this.onSelected,
  });

  final String title;
  final String bannerUrl;
  final dynamic selectedOptionKey;
  final List<SelectionOptionItem> options;
  final Function(dynamic) onSelected;
}
