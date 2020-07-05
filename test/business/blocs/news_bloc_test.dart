import 'package:covtrack/business/blocs/news/news_bloc.dart';
import 'package:covtrack/business/repositories/news/news_repository.dart';
import 'package:covtrack/data/news.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  group('NewsBloc', () {
    NewsRepository newsRepository;
    NewsBloc newsBloc;
    final News localNews = News(
      date: DateTime.now(),
      confirmed: 100000,
      deaths: 200000,
      recovered: 300000,
    );
    final News globalNews = News(
      date: DateTime.now(),
      confirmed: 150000,
      deaths: 250000,
      recovered: 350000,
    );

    setUp(() {
      newsRepository = MockNewsRepository();
      newsBloc = NewsBloc(newsRepository: newsRepository);
    });

    test('throws AssertionError if NewsRepository is null', () {
      expect(
        () => NewsBloc(newsRepository: null),
        throwsA(isAssertionError),
      );
    });
    test('initial state is NewsInitial', () {
      expect(newsBloc.state, NewsInitial());
    });

    group('NewsFetched', () {
      blocTest(
        'emits [NewsLoadInProgress, NewsLoadSuccess] if no exceptions are raised',
        build: () async {
          when(newsRepository.getCountryLatestNews()).thenAnswer(
            (_) async => localNews,
          );
          when(newsRepository.getGlobalLatestNews()).thenAnswer(
            (_) async => globalNews,
          );
          return newsBloc;
        },
        act: (bloc) => bloc.add(NewsFetched()),
        expect: [
          NewsLoadInProgress(),
          NewsLoadSuccess(
            localNews: localNews,
            globalNews: globalNews,
          ),
        ],
      );

      blocTest(
        'emits [NewsLoadInProgress, NewsLoadFailure] if an exception is raised',
        build: () async {
          when(newsRepository.getCountryLatestNews()).thenAnswer(
            (_) async => localNews,
          );
          when(newsRepository.getGlobalLatestNews()).thenThrow(Error());
          return newsBloc;
        },
        act: (bloc) => bloc.add(NewsFetched()),
        expect: [
          NewsLoadInProgress(),
          NewsLoadFailure(message: null),
        ],
      );
    });
  });
}
