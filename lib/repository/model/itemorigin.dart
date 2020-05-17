class ItemOrigin {
  final String streamId;
  final String title;
  final String htmlUrl;

  ItemOrigin(this.streamId, this.title, this.htmlUrl);

  factory ItemOrigin.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;
    return ItemOrigin(json["streamId"], json["title"], json["htmlUrl"]);
  }

  @override
  String toString() {
    return '''{
      'streamId': ${this.streamId},
      'title': ${this.title},
      'htmlUrl': ${this.htmlUrl}
    }''';
  }
}
