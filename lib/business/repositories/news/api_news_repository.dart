import 'dart:convert';
import 'dart:ui';

import 'package:country_code/country_code.dart';

import 'package:http/http.dart' as http;

import '../../../data/news.dart';
import '../../../utils/custom_exceptions.dart';
import 'news_repository.dart';

/// Implementation of the [NewsRepository] interface.
class ApiNewsRepository implements NewsRepository {
  final String _baseUrl = 'https://covidapi.info/api/v1';

  @override
  Future<News> getCountryLatestNews() async {
    final latestDate = await _latestDate;
    final latestDateString = latestDate.toString().split(' ').first;

    // The country code is in the ISO3166 standard format.
    final countryCode = CountryCode.tryParse(window.locale.countryCode).alpha3;

    final path = '/country/$countryCode/latest';
    final response = await http.get(_baseUrl + path);

    return News.fromJsonLocal(
      json.decode(_responseBody(response)),
      latestDateString,
    );
  }

  @override
  Future<News> getGlobalLatestNews() async {
    final path = '/global';

    final response = await http.get(_baseUrl + path);

    return News.fromJsonGlobal(
      json.decode(_responseBody(response)),
    );
  }

  Future<DateTime> get _latestDate async {
    final path = '/latest-date';

    final response = await http.get(_baseUrl + path);

    return DateTime.parse(
      _responseBody(response),
    );
  }

  dynamic _responseBody(http.Response response) {
    final body = response.body;
    final statusCode = response.statusCode;

    switch (statusCode) {
      case 200:
        return body;
      case 400:
        throw BadRequestException(body.toString());
      case 401:
        throw UnauthorizedException(body.toString());
      case 403:
        throw ForbiddenException(body.toString());
      case 404:
        throw NotFoundException(body.toString());
      case 500:
        throw InternalServerErrorException(body.toString());
      case 502:
        throw BadGatewayException(body.toString());
      case 503:
        throw ServiceUnavailableException(body.toString());
      case 504:
        throw GatewayTimeoutException(body.toString());
      default:
        throw CustomException(
          'Error occured while communicating with the server with status code: $statusCode',
        );
    }
  }
}
