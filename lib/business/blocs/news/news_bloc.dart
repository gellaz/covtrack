import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../data/news.dart';
import '../../repositories/news/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

/// BLoC responsible for the business logic behind the news section of the app by
/// fetching the data from the Covid-19 API. In particular this BLoC will map the
/// incoming [NewsEvent] to the correct [NewsState].
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  /// News repository used to fetch data from the Covid-19 API.
  final NewsRepository newsRepository;

  NewsBloc({@required this.newsRepository})
      : assert(newsRepository != null),
        super(NewsInitial());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is NewsFetched) {
      yield NewsLoadInProgress();
      try {
        final localNews = await newsRepository.getCountryLatestNews();
        final globalNews = await newsRepository.getGlobalLatestNews();
        yield NewsLoadSuccess(localNews: localNews, globalNews: globalNews);
      } catch (e) {
        yield NewsLoadFailure(message: e.toString());
      }
    }
  }
}
