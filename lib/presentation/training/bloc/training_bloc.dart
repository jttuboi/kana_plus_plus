import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kwriting/presentation/training/training.dart';

part 'training_event.dart';
part 'training_state.dart';

class TrainingBloc extends Bloc<TrainingEvent, TrainingState> {
  TrainingBloc(ListBloc listBloc) : super(const TrainingInitial()) {
    on<TrainingStarted>(_onTrainingStarted);

    _listSubscription = listBloc.stream.listen((listState) {
      if (listState is ListReady) {
        add(const TrainingStarted());
      }
    });
  }

  late StreamSubscription _listSubscription;

  Future<void> _onTrainingStarted(TrainingStarted event, Emitter<TrainingState> emit) async {
    emit(const TrainingReady());
  }

  @override
  Future<void> close() {
    _listSubscription.cancel();
    return super.close();
  }
}
