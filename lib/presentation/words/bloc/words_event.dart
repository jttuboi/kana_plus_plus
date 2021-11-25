part of 'words_bloc.dart';

abstract class WordsEvent extends Equatable {
  const WordsEvent();

  @override
  List<Object> get props => [];
}

class WordsLoaded extends WordsEvent {
  const WordsLoaded(this.languageCode);

  final String languageCode;

  @override
  List<Object> get props => [languageCode];

  @override
  String toString() => 'WordsLoaded()';
}
