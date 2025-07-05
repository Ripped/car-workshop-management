import 'package:cwm_desktop_mobile/models/notification.dart';
import 'package:cwm_desktop_mobile/models/searches/notification_search.dart';
import 'package:cwm_desktop_mobile/providers/base_provider.dart';

class NotificationProvider
    extends BaseProvider<Notification, NotificationSearch> {
  @override
  Notification fromJson(data) => Notification.fromJson(data);
}
