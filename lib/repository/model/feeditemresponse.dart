import 'package:porua/repository/model/direction.dart';
import 'package:porua/repository/model/feeditem.dart';
import 'package:porua/repository/model/itemurl.dart';
import 'package:porua/repository/util/jsonutil.dart';

class FeedItemResponse {
  final Direction direction;
  final String id;
  final String title;
  final String description;
  final ItemURL self;
  final DateTime updated;
  final List<FeedItem> items;
  final int continuation;

  FeedItemResponse(
    this.direction,
    this.id,
    this.title,
    this.description,
    this.self,
    this.updated,
    this.items,
    this.continuation);

  FeedItemResponse.fromJson(Map<String, dynamic> json):
    this(
      directionFromString(json["direction"]),
      json["id"],
      json["title"],
      json["description"],
      ItemURL.fromJson(json["self"]),
      parseTimestampSec(json["updated"]),
      parseArray(json["items"], (v) => FeedItem.fromJson(v)),
      int.parse(json["continuation"].toString()));
}