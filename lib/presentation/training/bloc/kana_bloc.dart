// ignore_for_file: avoid_redundant_argument_values

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kwriting/presentation/training/training.dart';

part 'kana_event.dart';
part 'kana_state.dart';

class KanaBloc extends Bloc<KanaEvent, KanaState> {
  KanaBloc(ListBloc listBloc)
      : super((listBloc.state is ListReady)
            ? KanaReady(
                index: (listBloc.state as ListReady).kanaIndex,
                total: (listBloc.state as ListReady).words[(listBloc.state as ListReady).wordIndex].kanas.length,
                kanas: (listBloc.state as ListReady).words[(listBloc.state as ListReady).wordIndex].kanas,
              )
            : const KanaInitial()) {
    on<KanaUpdated>(_onKanaUpdated);

    _listSubscription = listBloc.stream.listen((listState) async {
      if (listState is ListReady) {
        if (listState is ListWordReady) {
          await _delayedChangePage();
        }
        add(KanaUpdated(kanaIndex: listState.kanaIndex, kanas: listState.words[listState.wordIndex].kanas));
      }
    });
  }

  late final StreamSubscription _listSubscription;

  Future<void> _onKanaUpdated(KanaUpdated event, Emitter<KanaState> emit) async {
    emit(KanaReady(index: event.kanaIndex, total: event.kanas.length, kanas: event.kanas));
  }

  @override
  Future<void> close() {
    _listSubscription.cancel();
    return super.close();
  }

  Future<void> _delayedChangePage() async {
    await Future.delayed(const Duration(milliseconds: 300));
  }
}
