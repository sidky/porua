import 'dart:async';

class PaginationState<T> {
  final List<T> items;
  final bool isLoading;
  final bool hasMore;

  PaginationState(this.items, this.isLoading, this.hasMore);
}

class PaginationUtil<T> {
  final List<T> _items = List();
  bool _hasMore = true;

  final StreamController _controller = StreamController();
  final StreamIterator<T> _iterator;
  final int _pageSize;
  bool _isLoading;

  PaginationUtil(Stream<T> stream, {pageSize = 10}): this._pageSize = pageSize, this._iterator = StreamIterator(stream);

  Future<void> loadMore() async {
    if (!_hasMore) {
      return;
    }
    _controller.add(_currentState(true));

    for (int i = 0; i < this._pageSize; i++) {
      this._hasMore = await _iterator.moveNext();
      if (!this._hasMore) {
        break;
      } else {
        this._items.add(this._iterator.current);
      }
    }

    _controller.add(_currentState(false));
  }

  PaginationState<T> _currentState(bool isLoading) => PaginationState(this._items, isLoading, this._hasMore);
}