import 'package:get_it/get_it.dart';
import 'package:porua/repository/api/oldreader.dart';
import 'package:porua/repository/authrepository.dart';
import 'package:porua/repository/model/apierror.dart';
import 'package:porua/repository/model/feeditem.dart';
import 'package:porua/repository/model/feeditemresponse.dart';

class PaginatedFeed {
  final int _continuation;
  final List<FeedItem> items;

  PaginatedFeed(this._continuation, this.items);

  bool get hasMore => _continuation != null;
}

class FeedRepository {
  AuthRepository _authRepository;
  OldReaderAPI _api;

  FeedRepository({AuthRepository authRepository, OldReaderAPI api}) {
    this._authRepository = authRepository ?? GetIt.I.get();
    this._api = api ?? GetIt.I.get();
  }

  Stream<FeedItem> feedStream() async* {
    int continuation = null;

    do {
      if (!_authRepository.isAuthenticated()) {
        throw UnauthenticatedError();
      }

      FeedItemResponse response = await _api.feedStream(_authRepository.currentAuth.authId, continuation: continuation);

      for (var item in response.items) {
        yield item;
      }

      continuation = response.continuation;

    } while (continuation != null);
  }

  Future<PaginatedFeed> load({PaginatedFeed continuedFrom}) async {
    int continuation = null;

    if (continuedFrom != null) {
      if (!continuedFrom.hasMore) {
        return PaginatedFeed(null, List());
      }
      continuation = continuedFrom._continuation;
    }

    if (!_authRepository.isAuthenticated()) {
      throw UnauthenticatedError();
    }

    FeedItemResponse response = await _api.feedStream(_authRepository.currentAuth.authId, continuation: continuation);

    return PaginatedFeed(response.continuation, response.items);
  }
}