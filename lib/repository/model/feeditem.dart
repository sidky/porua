import 'package:porua/repository/model/itemurl.dart';
import 'package:porua/repository/util/jsonutil.dart';

class FeedItem {
  final DateTime crawlTime;
  final DateTime timestamp;
  final String id;
  final List<String> categoryIds;
  final String title;
  final DateTime published;
  final DateTime updated;
  final String torIdentifier;
  final List<ItemURL> canonical;
  final List<ItemURL> alternate;

  FeedItem(
    this.crawlTime, 
    this.timestamp, 
    this.id,
    this.categoryIds, 
    this.title, 
    this.published,
    this.updated,
    this.torIdentifier,
    this.canonical,
    this.alternate);

  factory FeedItem.fromJson(Map<String, dynamic> json) {
    DateTime crawlTime = parseTimestampMillis(json["crawlTimeMsec"]);
    DateTime timestamp = parseTimestampMicrosec(json["timestampUsec"]);
    List<String> categoryIds = parseArray(json["categories"], (v) => v as String);
    DateTime published = parseTimestampSec(json["published"]);
    DateTime updated = parseTimestampSec(json["updated"]);
    List<ItemURL> canonical = parseArray(json["canonical"], (v) => ItemURL.fromJson(v));
    List<ItemURL> alternate = parseArray(json["alternate"], (v) => ItemURL.fromJson(v));

    return FeedItem(
      crawlTime, 
      timestamp, 
      json["id"], 
      categoryIds, 
      json["title"], 
      published, 
      updated, 
      json["tor_identifier"], 
      canonical, 
      alternate);
  }
}