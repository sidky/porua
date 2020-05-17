import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get_it/get_it.dart';
import 'package:porua/repository/feedrepository.dart';
import 'package:porua/repository/model/feeditem.dart';
import 'package:porua/repository/model/itemorigin.dart';

class FeedWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FeedWidgetState();
}

class FeedWidgetState extends State<FeedWidget> {
  List<FeedItem> _items = List();
  bool _hasMore = true;
  PaginatedFeed _last = null;

  final ScrollController _scrollController = ScrollController();

  FeedWidgetState() {
    _scrollController.addListener(() {
      var isEnd = _scrollController.offset ==
          _scrollController.position.maxScrollExtent;

      if (isEnd && _hasMore) {
        _loadMore();
      }
    });
  }

  Widget build(BuildContext context) {
    @override
    var itemCount = _items.length + (_hasMore ? 1 : 0);

    if (_items.isEmpty && _hasMore) {
      _loadMore();
    }
    return Scaffold(
        body: ListView.builder(
            controller: _scrollController,
            itemCount: itemCount,
            itemBuilder: (context, index) {
              if (_hasMore && index == _items.length) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[CircularProgressIndicator()],
                );
              } else {
                return FeedItemWidget(_items[index]);
              }
            }));
  }

  Future<void> _loadMore() async {
    FeedRepository repository = GetIt.I.get();

    print("Load more");

    PaginatedFeed current = await repository.load(continuedFrom: _last);
    print("Loaded: ${current.items.length}");

    setState(() {
      this._last = current;
      this._hasMore = current.hasMore;
      this._items.addAll(current.items);
    });
  }
}

class FeedItemWidget extends StatelessWidget {
  final FeedItem _item;

  FeedItemWidget(this._item);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  _item.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SourceAndAuthorWidget(_item.origin, _item.author),
                Html(data: _item.summary.content)
              ],
            )));
  }
}

class SourceAndAuthorWidget extends StatelessWidget {
  final ItemOrigin _origin;
  final String _author;

  SourceAndAuthorWidget(this._origin, this._author);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          child: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(
                this._origin.title,
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              )),
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 47, 84, 31),
              borderRadius: BorderRadius.circular(5.0)),
        ),
        Visibility(
            visible: _author != null && _author.isNotEmpty,
            child: Row(
              children: <Widget>[
                SizedBox(width: 5),
                Text("by"),
                SizedBox(width: 5),
                Text(
                  _author,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ))
      ],
    );
  }
}
