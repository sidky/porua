import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:porua/repository/model/category.dart';
import 'package:porua/repository/model/subscription.dart';

void main() {
  test("Verify OldReaderSubscription parsing works", () {
    const String body = '''
    {
      "id": "feed/5ad900c60914528e470001c4",
      "title": "Language Log",
      "categories": [
        {
          "id": "user/-/label/thinkers",
          "label": "thinkers"
        }
      ],
      "sortid": "5ad900c60914528e470001c4",
      "firstitemmsec": "1357049834000",
      "url": "http://itre.cis.upenn.edu/~myl/languagelog/index.rdf",
      "htmlUrl": "http://itre.cis.upenn.edu/~myl/languagelog/",
      "iconUrl": "//s.theoldreader.com/system/uploads/feed/picture/50e2/ea0d/e721/ecaf/7300/icon_0554.ico"
    }
    ''';

    var parsed = json.decode(body);
    var subscription = OldReaderSubscription.fromJson(parsed);

    expect(subscription.id, equals("feed/5ad900c60914528e470001c4"));
    expect(subscription.title, equals("Language Log"));
    expect(subscription.category, equals([Category("user/-/label/thinkers", "thinkers")]));
    expect(subscription.sortId, equals("5ad900c60914528e470001c4"));
    expect(subscription.firstItem, equals(DateTime.fromMillisecondsSinceEpoch(1357049834000 * 1000)));
    expect(subscription.url, equals("http://itre.cis.upenn.edu/~myl/languagelog/index.rdf"));
    expect(subscription.htmlUrl, equals("http://itre.cis.upenn.edu/~myl/languagelog/"));
    expect(subscription.iconUrl, equals("//s.theoldreader.com/system/uploads/feed/picture/50e2/ea0d/e721/ecaf/7300/icon_0554.ico"));
  });

  test("Verify parsing when category is not defined", () {
    const String body = '''
    {
      "id": "feed/5ad900c60914528e470001c4",
      "title": "Language Log",
      "categories": [],
      "sortid": "5ad900c60914528e470001c4",
      "firstitemmsec": "1357049834000",
      "url": "http://itre.cis.upenn.edu/~myl/languagelog/index.rdf",
      "htmlUrl": "http://itre.cis.upenn.edu/~myl/languagelog/",
      "iconUrl": "//s.theoldreader.com/system/uploads/feed/picture/50e2/ea0d/e721/ecaf/7300/icon_0554.ico"
    }
    ''';

    var parsed = json.decode(body);
    var subscription = OldReaderSubscription.fromJson(parsed);

    expect(subscription.id, equals("feed/5ad900c60914528e470001c4"));
    expect(subscription.title, equals("Language Log"));
    expect(subscription.category, isEmpty);
    expect(subscription.sortId, equals("5ad900c60914528e470001c4"));
    expect(subscription.firstItem, equals(DateTime.fromMillisecondsSinceEpoch(1357049834000 * 1000)));
    expect(subscription.url, equals("http://itre.cis.upenn.edu/~myl/languagelog/index.rdf"));
    expect(subscription.htmlUrl, equals("http://itre.cis.upenn.edu/~myl/languagelog/"));
    expect(subscription.iconUrl, equals("//s.theoldreader.com/system/uploads/feed/picture/50e2/ea0d/e721/ecaf/7300/icon_0554.ico"));
  });

}