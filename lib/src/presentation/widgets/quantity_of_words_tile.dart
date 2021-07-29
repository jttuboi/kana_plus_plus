import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/j_strings.dart';
import 'package:kana_plus_plus/src/presentation/state_management/quantity_of_words.provider.dart';
import 'package:provider/provider.dart';

class QuantityOfWordsTile extends StatelessWidget {
  const QuantityOfWordsTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JStrings strings = JStrings.of(context)!;
    return Consumer<QuantityOfWordsProvider>(
      builder: (context, provider, child) {
        return ListTile(
          leading: ImageIcon(AssetImage(provider.iconUrl)),
          title: Text(strings.settingsQuantityOfWords),
          subtitle: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackShape: _CustomTrackShape(),
            ),
            child: Slider(
              value: provider.quantity.toDouble(),
              onChanged: (value) {
                provider.updateQuantity(value);
              },
              divisions: provider.divisions,
              label: provider.quantity.toString(),
              min: provider.minWords.toDouble(),
              max: provider.maxWords.toDouble(),
            ),
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
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx + 6;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width - 22;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
