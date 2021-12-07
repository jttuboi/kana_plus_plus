import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/shared/shared.dart';
import 'package:kwriting/presentation/training/training.dart';
import 'package:mocktail/mocktail.dart';

import '../../../utils/mocks.dart';
import '../../../utils/utils.dart';

void main() {
  group('Writer', () {
    final mockWriterBloc = MockWriterBloc();

    testWidgets('renders correctly when is state initial', (tester) async {
      when(() => mockWriterBloc.state).thenReturn(const WriterInitial());
      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<WriterBloc>(
          create: (context) => mockWriterBloc,
          child: const Writer(squareSize: 100, borderSize: 4, showHint: false),
        ),
      ));

      tester.expectWidget<Container>(widgetQuantityExpected: 2);
    });

    testWidgets('renders correctly when is state wait', (tester) async {
      when(() => mockWriterBloc.state).thenReturn(const WriterWait(
        strokesForDraw: ['M 66.87 26.75 C 68.2729 27.6427 69.8058 29.0247 71.2034 30.5786 C 72.5455 32.0708 73.7627 33.7216 74.62 35.25'],
      ));
      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<WriterBloc>(
          create: (context) => mockWriterBloc,
          child: const Writer(squareSize: 100, borderSize: 4, showHint: false),
        ),
      ));

      tester
        ..expectCustomPaintWith<BorderPainter>()
        ..expectWidget<BlocBuilder<WriterBloc, WriterState>>(widgetQuantityExpected: 2)
        ..expectCustomPaintWith<AllStrokesPainter>()
        ..expectWidget<WriteCurrentStroke>();
    });

    testWidgets('renders correctly when is state enf', (tester) async {
      when(() => mockWriterBloc.state).thenReturn(const WriterEnd(
        kanaId: 'A',
        strokesForDraw: ['M 66.87 26.75 C 68.2729 27.6427 69.8058 29.0247 71.2034 30.5786 C 72.5455 32.0708 73.7627 33.7216 74.62 35.25'],
        userStrokes: [],
        corrects: [],
      ));
      await tester.pumpWidget(MaterialApp(
        home: BlocProvider<WriterBloc>(
          create: (context) => mockWriterBloc,
          child: const Writer(squareSize: 100, borderSize: 4, showHint: false),
        ),
      ));

      tester
        ..expectCustomPaintWith<BorderPainter>()
        ..expectWidget<BlocBuilder<WriterBloc, WriterState>>(widgetQuantityExpected: 2)
        ..expectCustomPaintWith<AllStrokesPainter>();
    });
  });
}
