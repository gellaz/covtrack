part of 'news_bloc.dart';

/// [NewsFetched] is the only event that [NewsBloc] will need to know how to process. It simply
/// notifies [NewsBloc] that the data from Covid-19 API has been collected.
abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class NewsFetched extends NewsEvent {}
