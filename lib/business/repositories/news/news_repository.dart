import '../../../data/news.dart';

abstract class NewsRepository {
  Future<News> getCountryLatestNews();
  Future<News> getGlobalLatestNews();
}
