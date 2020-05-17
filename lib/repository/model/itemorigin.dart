class ItemOrigin {
  final String streamId;
  final String title;
  final String htmlUrl;

  ItemOrigin(this.streamId, this.title, this.htmlUrl);

  ItemOrigin.fromJson(Map<String, dynamic> json): 
      this(json["streamId"], json["title"], json["htmlUrl"]);

  @override
  String toString() {
    return '''{
      'streamId': ${this.streamId},
      'title': ${this.title},
      'htmlUrl': ${this.htmlUrl}
    }''';
  }
}