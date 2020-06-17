import 'package:covtrack/business/blocs/news/news_bloc.dart';
import 'package:covtrack/business/repositories/news/news_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  NewsRepository newsRepository;
  NewsBloc newsBloc;

  group('NewsBloc', () {
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
      expect(newsBloc.initialState, NewsInitial());
    });
  });
}
