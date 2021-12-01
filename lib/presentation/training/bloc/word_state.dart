part of 'word_bloc.dart';

abstract class WordState extends Equatable {
  const WordState();

  @override
  List<Object> get props => [];
}

class WordInitial extends WordState {
  const WordInitial();
}

class WordReady extends WordState {
  const WordReady({
    this.index = 0,
    this.total = 0,
    this.translate = '',
    this.imageUrl = ImageUrl.empty,
  });

  final int index;
  final int total;
  final String translate;
  final String imageUrl;

  @override
  List<Object> get props => [index, total, translate, imageUrl];
}
