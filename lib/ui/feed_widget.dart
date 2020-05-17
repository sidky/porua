import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:porua/repository/feedrepository.dart';
import 'package:porua/repository/model/feeditem.dart';

class FeedWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FeedWidgetState();

}

class FeedWidgetState extends State<FeedWidget> {

  List<FeedItem> _items = List();
  bool _hasMore = false;
  PaginatedFeed _last = null;

  @override
  Widget build(BuildContext context) {
    var itemCount = _items.length + (_hasMore ? 1 : 0);
    return Scaffold(
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (_hasMore && index == _items.length) {
            return CircularProgressIndicator();
          } else {
            return Text(_items[index].title);
          }
        })
    );
  }

  Future<void> _loadMore() async {
    FeedRepository repository = GetIt.I.get();

    PaginatedFeed current = await repository.load(continuedFrom: _last);

    setState(() {
      this._last = current;
      this._hasMore = current.hasMore;
      this._items.addAll(current.items);
    });
  }
}