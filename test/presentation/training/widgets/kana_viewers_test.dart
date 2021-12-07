import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';
import '../../../utils/utils.dart';

void main() {
  group('KanaViewers', () {
    final mockKanaBloc = MockKanaBloc();

    testWidgets('renders kana viewers shimmer', (tester) async {
      when(() => mockKanaBloc.state).thenReturn(const KanaInitial());
      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<KanaBloc>(
          create: (context) => mockKanaBloc,
          child: const KanaViewers(width: 200, height: 40),
        ),
      ));

      tester
        ..expectWidget<Shimmer>()
        ..expectWidget<ShimmerKanaViewer>();
    });

    testWidgets('renders correctly', (tester) async {
      when(() => mockKanaBloc.state).thenReturn(const KanaReady(total: 2, kanas: [
        KanaViewModel(id: 'id', status: KanaViewerStatus.select, kanaType: KanaType.hiragana, romaji: 'romaji', strokes: []),
        KanaViewModel(id: 'id', status: KanaViewerStatus.normal, kanaType: KanaType.hiragana, romaji: 'romaji', strokes: []),
      ]));
      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<KanaBloc>(
          create: (context) => mockKanaBloc,
          child: const KanaViewers(width: 200, height: 40),
        ),
      ));

      tester
        ..expectWidget<CarouselSlider>()
        ..expectWidget<KanaViewer>(widgetQuantityExpected: 2);
    });
  });
}
