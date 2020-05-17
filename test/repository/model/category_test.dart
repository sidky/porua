import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:porua/repository/model/category.dart';

void main() {
  test("Tests parsing a category works", () {
    const String body = '''{
          "id": "user/-/label/thinkers",
          "label": "thinkers"
        }''';

    var parsed = json.decode(body);
    var category = Category.fromJson(parsed);

    expect(category.id, equals("user/-/label/thinkers"));
    expect(category.label, equals("thinkers"));
  });
}