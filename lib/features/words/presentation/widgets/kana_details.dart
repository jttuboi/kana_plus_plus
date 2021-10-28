import 'package:flutter/widgets.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:kwriting/features/training/training.dart';
import 'package:kwriting/features/words/words.dart';

class KanasDetails extends StatelessWidget {
  KanasDetails({required this.kanas, Key? key}) : super(key: key);

  final kanaDetailSpaceBetweenKanas = Device.get().isTablet ? 6.0 : 2.0;

  final List<Kana> kanas;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Device.get().isTablet ? 80.0 : 40.0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final kanaWidth = (constraints.maxWidth - kanaDetailSpaceBetweenKanas * (kanas.length - 1)) / kanas.length;
          final kanaSize = (kanaWidth < constraints.maxHeight) ? kanaWidth : constraints.maxHeight;

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: kanas.length,
            itemBuilder: (context, index) {
              return KanaDetail(imageUrl: kanas[index].imageUrl, size: kanaSize);
            },
            separatorBuilder: (context, index) => Container(width: kanaDetailSpaceBetweenKanas),
          );
        },
      ),
    );
  }
}
