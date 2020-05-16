abstract class Dao<T> {
  /// SQL query to create a table.
  String get createTableQuery;

  /// Abstract mapping methods.
  List<T> fromList(List<Map<String, dynamic>> mapsList);
  T fromMap(Map<String, dynamic> map);
  Map<String, dynamic> toMap(T object);
}
