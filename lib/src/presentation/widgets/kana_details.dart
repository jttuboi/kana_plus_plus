import 'package:flutter/widgets.dart';
import 'package:kwriting/src/domain/entities/kana.dart';
import 'package:kwriting/src/presentation/utils/consts.dart';
import 'package:kwriting/src/presentation/widgets/kana_detail.dart';

class KanasDetails extends StatelessWidget {
  const KanasDetails({required this.kanas, Key? key}) : super(key: key);

  final List<Kana> kanas;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kanaDetailHeight,
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
