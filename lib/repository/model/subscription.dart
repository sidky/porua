import 'package:porua/repository/model/category.dart';
import 'package:porua/repository/util/jsonutil.dart';

class OldReaderSubscription {
  final String id;
  final String title;
  final List<Category> category;
  final String sortId;
  final DateTime firstItem;
  final String url;
  final String htmlUrl;
  final String iconUrl;

  OldReaderSubscription(this.id, this.title, this.category, this.sortId, this.firstItem, this.url, this.htmlUrl, this.iconUrl);

  factory OldReaderSubscription.fromJson(Map<String, dynamic> json) {
    List<Category> categories = parseArray<Category>(json["categories"], (Map<String, dynamic> p) => Category.fromJson(p));
    var firstItem = DateTime.fromMillisecondsSinceEpoch(int.parse(json["firstitemmsec"]) * 1000);

    return OldReaderSubscription(json["id"], json["title"], categories, json["sortid"], firstItem, json["url"], json["htmlUrl"], json["iconUrl"]);
  }}