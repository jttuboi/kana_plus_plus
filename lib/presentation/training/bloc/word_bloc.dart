import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kwriting/domain/domain.dart';
import 'package:kwriting/presentation/training/training.dart';

part 'word_event.dart';
part 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  WordBloc(ListBloc listBloc)
      : super((listBloc.state is ListReady)
            ? WordReady(
                index: (listBloc.state as ListReady).wordIndex,
                total: (listBloc.state as ListReady).words.length,
                translate: (listBloc.state as ListReady).words[(listBloc.state as ListReady).wordIndex].translate,
                imageUrl: (listBloc.state as ListReady).words[(listBloc.state as ListReady).wordIndex].imageUrl,
              )
            : const WordInitial()) {
    on<WordUpdated>(_onWordUpdated);

    _listSubscription = listBloc.stream.listen((listState) async {
      if (listState is ListWordReady) {
        await _delayedChangePage();
        add(WordUpdated(wordIndex: listState.wordIndex, words: listState.words));
      }
    });
  }

  late final StreamSubscription _listSubscription;

  Future<void> _onWordUpdated(WordUpdated event, Emitter<WordState> emit) async {
    emit(WordReady(
      index: event.wordIndex,
      total: event.words.length,
      translate: event.words[event.wordIndex].translate,
      imageUrl: event.words[event.wordIndex].imageUrl,
    ));
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
