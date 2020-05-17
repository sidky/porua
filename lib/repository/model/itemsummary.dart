import 'package:porua/repository/model/direction.dart';
import 'package:porua/repository/model/itemorigin.dart';

class ItemSummary {
  final Direction direction;
  final String content;
  final String author;
  final ItemOrigin itemOrigin;

  ItemSummary(this.direction, this.content, this.author, this.itemOrigin);

  ItemSummary.fromJson(Map<String, dynamic> json): 
      this(directionFromString(json["direction"]), json["content"], json["author"], ItemOrigin.fromJson(json["origin"]));
}