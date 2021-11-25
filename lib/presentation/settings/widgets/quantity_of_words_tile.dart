import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kwriting/core/core.dart';
import 'package:kwriting/presentation/settings/settings.dart';
import 'package:provider/provider.dart';

class QuantityOfWordsTile extends StatelessWidget {
  const QuantityOfWordsTile({Key? key}) : super(key: key);

  int get _step => 1;

  @override
  Widget build(BuildContext context) {
    final strings = JStrings.of(context)!;

    return Consumer<QuantityOfWordsChangeNotifier>(
      builder: (context, changeNotifier, child) {
        return ListTile(
          title: Text(strings.settingsQuantityOfWords),
          subtitle: SizedBox(
            height: 36,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(trackShape: _CustomTrackShape()),
              child: Slider(
                value: changeNotifier.quantity.toDouble(),
                label: changeNotifier.quantity.toString(),
                min: Default.minimumTrainingCards.toDouble(),
                max: Default.maximumTrainingCards.toDouble(),
                divisions: (Default.maximumTrainingCards.toDouble() - Default.minimumTrainingCards.toDouble()) ~/ _step,
                onChanged: (value) => changeNotifier.updateQuantity(value.toInt()),
              ),
            ),
          ),
          leading: SizedBox(
            height: double.infinity,
            child: SvgPicture.asset(IconUrl.quantityOfWords, color: defaultTileIconColor, width: defaultTileIconSize),
          ),
        );
      },
    );
  }
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    Offset offset = Offset.zero,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight!;
    final trackLeft = offset.dx + 6;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final trackWidth = parentBox.size.width - 22;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
