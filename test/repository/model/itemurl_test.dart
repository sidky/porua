import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:porua/repository/model/itemurl.dart';

void main() {
  test("Test parse ItemURL", () {
    const body = '''
    {
      "href": "https://www.theverge.com/2020/5/14/21259446/ubisoft-assassins-creed-odyssey-origins-greece-egypt-free-discovery-tours",
      "type": "text/html"
    }
    ''';

    var parsed = json.decode(body);
    var url = ItemURL.fromJson(parsed);

    expect(url.href, equals("https://www.theverge.com/2020/5/14/21259446/ubisoft-assassins-creed-odyssey-origins-greece-egypt-free-discovery-tours"));
    expect(url.type, equals("text/html"));
  });

  test("Test parse succeeds if type does not exist", () {
    const body = '''
    {
      "href": "https://www.theverge.com/2020/5/14/21259446/ubisoft-assassins-creed-odyssey-origins-greece-egypt-free-discovery-tours"
    }
    ''';

    var parsed = json.decode(body);
    var url = ItemURL.fromJson(parsed);

    expect(url.href, equals("https://www.theverge.com/2020/5/14/21259446/ubisoft-assassins-creed-odyssey-origins-greece-egypt-free-discovery-tours"));
    expect(url.type, isNull);
  });

  test("Test parse succeeds if url is null", () {
    const body = '''
    {
      "a": "b"
    }
    ''';
    var parsed = json.decode(body);
    var url = ItemURL.fromJson(parsed["c"]);

    expect(url, isNull);
  });
}