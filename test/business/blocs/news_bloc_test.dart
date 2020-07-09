import 'package:covtrack/business/blocs/news/news_bloc.dart';
import 'package:covtrack/business/repositories/news/news_repository.dart';
import 'package:covtrack/data/news.dart';
import 'package:covtrack/utils/custom_exceptions.dart';
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

    tearDown(() {
      newsBloc?.close();
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

    test('close does not emit new states', () {
      expectLater(
        newsBloc,
        emitsInOrder([NewsInitial(), emitsDone]),
      );
      newsBloc.close();
    });

    group('NewsFetched', () {
      blocTest(
        'emits [NewsLoadInProgress, NewsLoadSuccess] and correctly provides local and global news if no exception is thrown',
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
        'emits [NewsLoadInProgress, NewsLoadFailure] if an exception is thrown',
        build: () async {
          when(newsRepository.getCountryLatestNews()).thenAnswer(
            (_) async => localNews,
          );
          when(newsRepository.getGlobalLatestNews())
              .thenThrow(NotFoundException());
          return newsBloc;
        },
        act: (bloc) => bloc.add(NewsFetched()),
        expect: [
          NewsLoadInProgress(),
          NewsLoadFailure(),
        ],
      );
    });
  });
}
