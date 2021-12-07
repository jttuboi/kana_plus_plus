import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kwriting/presentation/training/training.dart';

import '../../../utils/mocks.dart';

void main() {
  group('TrainingBloc', () {
    final mockListBloc = MockListBloc();

    blocTest<TrainingBloc, TrainingState>(
      'emits [TrainingReady] when TrainingStarted is added',
      build: () => TrainingBloc(mockListBloc),
      act: (bloc) => bloc.add(const TrainingStarted()),
      expect: () => const <TrainingState>[TrainingReady()],
    );
  });
}
