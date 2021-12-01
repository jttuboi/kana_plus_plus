import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ShimmerTrainingView extends StatelessWidget {
  const ShimmerTrainingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StepProgressIndicator(
          totalSteps: 1,
          size: Device.get().isTablet ? 6 : 5,
          padding: 0.5,
          selectedColor: Theme.of(context).colorScheme.secondary,
          unselectedColor: Colors.grey.shade400,
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  const Spacer(),
                  Container(
                    width: constraints.maxHeight * 10 / 30,
                    height: constraints.maxHeight * 10 / 30,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.black),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SizedBox(
                      width: constraints.maxWidth - 16 * 2, // 16 * 2 is the padding size for this content
                      height: constraints.maxHeight * 4 / 30,
                      child: ShimmerKanaViewer(height: constraints.maxHeight * 4 / 30),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Container(
                      width: constraints.maxHeight * 12 / 30,
                      height: constraints.maxHeight * 12 / 30,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.black),
                    ),
                  ),
                  const Spacer(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
