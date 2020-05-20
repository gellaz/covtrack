import '../../../data/models/info.dart';

abstract class InfoRepository {
  Future<Info> getCountryLatestInfo();
  Future<Info> getGlobalLatestInfo();
}
