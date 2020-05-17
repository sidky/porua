import 'package:get_it/get_it.dart';
import 'package:porua/repository/util/preferencesutil.dart';

void setup() {
  GetIt.I.registerLazySingleton(() => PreferencesUtil());
}