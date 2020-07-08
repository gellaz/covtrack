import 'package:covtrack/data/news.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('News', () {
    final News news1 = News(
      date: DateTime(2020, 1, 15),
      confirmed: 30,
      deaths: 20,
      recovered: 10,
    );
    final News news2 = News(
      date: DateTime(2020, 1, 15),
      confirmed: 11620096,
      deaths: 538058,
      recovered: 6302626,
    );
    final News news3 = News(
      date: DateTime(2020, 1, 15),
      confirmed: 30,
      deaths: 20,
      recovered: 10,
    );

    test('correctly deserialized from JSON (local)', () {
      expect(
        News.fromJsonLocal(
          {
            "result": {
              "2020-01-15": {
                "confirmed": 30,
                "deaths": 20,
                "recovered": 10,
              },
            }
          },
          '2020-01-15',
        ),
        news1,
      );
    });

    test('correctly deserialized from JSON (global)', () {
      expect(
        News.fromJsonGlobal({
          "date": "2020-01-15",
          "result": {
            "confirmed": 11620096,
            "deaths": 538058,
            "recovered": 6302626
          }
        }),
        news2,
      );
    });

    test(
        'copyWith method generates a copy of the object with only the specified properties updated',
        () {
      final News news1updated = News(
        date: DateTime(2020, 1, 15),
        confirmed: 100,
        deaths: 20,
        recovered: 10,
      );
      expect(news1.copyWith(confirmed: 100), news1updated);
      expect(news1, isNot(news1updated));
    });

    test('equality comparison uses the object properties and not references',
        () {
      expect(news1, isNot(news2));
      expect(news1, equals(news3));
    });
  });
}
