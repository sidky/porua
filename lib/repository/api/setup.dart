import 'package:get_it/get_it.dart';
import 'package:porua/repository/api/oldreader.dart';

void setup() {
  GetIt.I.registerSingleton(OldReaderAPI());
}