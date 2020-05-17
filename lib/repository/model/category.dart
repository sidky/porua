import 'package:flutter/foundation.dart';

class Category {
  final String id;
  final String label;

  Category(this.id, this.label);

  Category.fromJson(Map<String, dynamic> json): this.id = json["id"], this.label = json["label"];

  @override
  String toString() {
    return "{'id': ${this.id}, 'label': ${this.label} }";
  }

  @override
  bool operator ==(Object other) => 
      other is Category && other.id == this.id && other.label == this.label;

  @override
  int get hashCode {
    int hash = 7;
    hash = 31 * hash + this.id.hashCode;
    hash = 31 * hash + this.label.hashCode;
    return hash;
  }
}