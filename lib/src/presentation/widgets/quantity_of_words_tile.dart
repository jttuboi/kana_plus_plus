import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kana_plus_plus/src/data/datasources/icon_url.storage.dart';
import 'package:kana_plus_plus/src/domain/core/consts.dart';
import 'package:kana_plus_plus/src/presentation/utils/consts.dart';

class QuantityOfWordsTile extends StatelessWidget {
  const QuantityOfWordsTile({
    Key? key,
    required this.quantity,
    required this.updateQuantity,
  }) : super(key: key);

  final int quantity;
  final Function(double quantity) updateQuantity;

  int get _step => 1;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;
    return ListTile(
      leading: SizedBox(
        height: double.infinity,
        child: SvgPicture.asset(IconUrl.quantityOfWords, color: defaultTileIconColor, width: defaultTileIconSize),
      ),
      title: Text(strings.settingsQuantityOfWords),
      subtitle: SizedBox(
        height: 36,
        child: SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackShape: _CustomTrackShape(),
          ),
          child: Slider(
            value: quantity.toDouble(),
            label: quantity.toString(),
            min: Default.minimumTrainingCards.toDouble(),
            max: Default.maximumTrainingCards.toDouble(),
            divisions: (Default.maximumTrainingCards.toDouble() - Default.minimumTrainingCards.toDouble()) ~/ _step,
            onChanged: updateQuantity,
          ),
        ),
      ),
    );
  }
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx + 6;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 22;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
