part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoadInProgress extends NewsState {}

class NewsLoadSuccess extends NewsState {
  final News localNews;
  final News globalNews;

  const NewsLoadSuccess({
    @required this.localNews,
    @required this.globalNews,
  });

  @override
  List<Object> get props => [localNews, globalNews];

  @override
  String toString() =>
      'NewsLoadSuccess { localNews: $localNews, globalNews: $globalNews }';
}

class NewsLoadFailure extends NewsState {
  final String message;

  const NewsLoadFailure({this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'NewsLoadFailure { message: $message }';
}
