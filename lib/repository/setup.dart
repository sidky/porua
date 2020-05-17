import 'package:get_it/get_it.dart';
import 'package:porua/repository/api/oldreader.dart';
import 'package:porua/repository/authrepository.dart';
import 'package:porua/repository/feedrepository.dart';
import 'api/setup.dart' as api;
import 'util/setup.dart' as util;

void setupGetIt() {
  api.setup();
  util.setup();

  GetIt.I.registerSingleton(AuthRepository());
  GetIt.I.registerSingleton(FeedRepository());
}