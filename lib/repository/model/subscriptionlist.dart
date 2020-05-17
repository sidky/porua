import 'package:porua/repository/model/subscription.dart';
import 'package:porua/repository/util/jsonutil.dart';

class OldReaderSubscriptionList {
  final List<OldReaderSubscription> subscriptions;

  OldReaderSubscriptionList(this.subscriptions);

  OldReaderSubscriptionList.fromJson(Map<String, dynamic> json): 
      this(parseArray(json["subscriptions"], (v) => OldReaderSubscription.fromJson(v)));
}