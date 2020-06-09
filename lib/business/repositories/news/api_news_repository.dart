import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../data/news.dart';
import 'news_repository.dart';

class ApiNewsRepository implements NewsRepository {
  static const _authority = 'covidapi.info';

  @override
  Future<News> getCountryLatestNews() async {
    final latestDate = await _getLatestDate();
    final latestDateString = latestDate.toString().split(' ').first;
    final path = '/api/v1/country/ITA/latest';
    final uri = Uri.https(_authority, path);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return News.fromJsonLocal(json.decode(response.body), latestDateString);
    } else {
      throw Exception('Failed to load latest local information');
    }
  }

  @override
  Future<News> getGlobalLatestNews() async {
    final path = '/api/v1/global';
    final uri = Uri.https(_authority, path);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return News.fromJsonGlobal(json.decode(response.body));
    } else {
      throw Exception('Failed to load latest global information');
    }
  }

  Future<DateTime> _getLatestDate() async {
    final path = '/api/v1/latest-date';
    final uri = Uri.https(_authority, path);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return DateTime.parse(response.body);
    } else {
      throw Exception('Failed to load latest date');
    }
  }
}
