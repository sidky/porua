import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:porua/repository/util/jsonutil.dart';

void main() {
  test("Test json conversion for array", () {
    var sampleJson = "[{\"foo\": 1, \"bar\": \"baz1\"}, {\"foo\": 2, \"bar3\": \"baz2\"}, {\"foo\": 4, \"bar4\": \"baz4\"}]";
    var parsed = json.decode(sampleJson);

    var c = parseArray(parsed, (Map<String, dynamic> m) => m["foo"]);
    expect(c, [1, 2, 4]);
  });
}