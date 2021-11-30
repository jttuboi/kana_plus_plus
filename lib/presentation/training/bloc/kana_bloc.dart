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
    on<KanaPageChanged>(_onKanaPageChanged);

    _listSubscription = listBloc.stream.listen((listState) async {
      if (listState is! ListReady) {
        return;
      }

      if (listState is ListPageReady) {
        add(KanaPageChanged(wordIndex: listState.wordIndex, words: listState.words));
      } else {
        add(KanaUpdated(kanaIndex: listState.kanaIndex, wordIndex: listState.wordIndex, words: listState.words));
      }
    });
  }

  late final StreamSubscription _listSubscription;

  Future<void> _onKanaUpdated(KanaUpdated event, Emitter<KanaState> emit) async {
    emit(KanaReady(index: event.kanaIndex, total: event.words[event.wordIndex].kanas.length, kanas: event.words[event.wordIndex].kanas));
  }

  Future<void> _onKanaPageChanged(KanaPageChanged event, Emitter<KanaState> emit) async {
    final previousKanaIndex = (state as KanaReady).index;
    final previousWordIndex = event.wordIndex - 1;
    emit(KanaReady(index: previousKanaIndex, total: event.words[previousWordIndex].kanas.length, kanas: event.words[previousWordIndex].kanas));
  }

  @override
  Future<void> close() {
    _listSubscription.cancel();
    return super.close();
  }
}
