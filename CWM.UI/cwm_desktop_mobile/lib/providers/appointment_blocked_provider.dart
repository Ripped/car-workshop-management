import '../models/appointment_blocked.dart';
import '../models/searches/appointment_blocked_search.dart';
import 'base_provider.dart';

class AppointmentBlockedProvider
    extends BaseProvider<AppointmentBlocked, AppointmentBlockedSearch> {
  @override
  AppointmentBlocked fromJson(data) => AppointmentBlocked.fromJson(data);
}
