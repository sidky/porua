import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:porua/repository/model/subscriptionlist.dart';

void main() {
  test("Verify parsing subscription list", () {
    const body = '''
      {
        "subscriptions": [
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
          },
          {
            "id": "feed/5ad900a50914528e47000022",
            "title": "Fredo and Pidjin. The Webcomic.",
            "categories": [],
            "sortid": "5ad900a50914528e47000022",
            "firstitemmsec": "1573049946000",
            "url": "http://feeds.feedburner.com/Pidjin",
            "htmlUrl": "https://www.pidjin.net",
            "iconUrl": "//s.theoldreader.com/system/uploads/feed/picture/50e2/ea16/e721/ec28/6e00/icon_1ee8.ico"
          }
        ]
      }
    ''';

    var parsed = json.decode(body);
    var list = OldReaderSubscriptionList.fromJson(parsed);

    expect(list.subscriptions, hasLength(2));
    expect(list.subscriptions[0].id, equals("feed/5ad900c60914528e470001c4"));
    expect(list.subscriptions[0].category, hasLength(1));
    expect(list.subscriptions[0].url, equals("http://itre.cis.upenn.edu/~myl/languagelog/index.rdf"));
    expect(list.subscriptions[1].id, equals("feed/5ad900a50914528e47000022"));
    expect(list.subscriptions[1].category, isEmpty);
    expect(list.subscriptions[1].url, equals("http://feeds.feedburner.com/Pidjin"));
  });
}