class ItemURL {
  final String href;
  final String type;

  ItemURL(this.href, this.type);

  factory ItemURL.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    } else {
      return ItemURL(json["href"], json["type"]);
    }
  }

  @override
  String toString() {
    return "{'href': $href, 'type': $type}";
  }
}