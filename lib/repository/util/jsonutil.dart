List<T> parseArray<T>(dynamic json, Function converter) {
  return List.from(json).map<T>((e) => converter.call(e)).toList();
}

DateTime parseTimestampSec(dynamic value) => parseTimestamp(value, 1000);

DateTime parseTimestampMillis(dynamic value) => parseTimestamp(value, 1);

DateTime parseTimestamp(dynamic value, int exp) {
  return DateTime.fromMillisecondsSinceEpoch(int.parse(value.toString()) * exp);
}

DateTime parseTimestampMicrosec(dynamic value) {
  return DateTime.fromMillisecondsSinceEpoch(int.parse(value.toString()) ~/ 1000);
}
