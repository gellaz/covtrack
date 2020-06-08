import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/news.dart';
import '../../repositories/news/news_repository.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository infoRepository;

  NewsBloc(this.infoRepository) : assert(infoRepository != null);

  @override
  NewsState get initialState => NewsInitial();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    if (event is NewsFetched) {
      yield NewsLoadInProgress();
      try {
        final localNews = await infoRepository.getCountryLatestNews();
        final globalNews = await infoRepository.getGlobalLatestNews();
        yield NewsLoadSuccess(localNews, globalNews);
      } catch (e) {
        yield NewsLoadFailure(e.toString());
      }
    }
  }
}
