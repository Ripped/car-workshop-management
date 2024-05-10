import 'package:cwm_desktop_mobile/models/appointment_type.dart';
import 'package:cwm_desktop_mobile/models/searches/appointment_type_search.dart';
import 'package:cwm_desktop_mobile/providers/base_provider.dart';

class AppointmentTypeProvider
    extends BaseProvider<AppointmentType, AppointmentTypeSearch> {
  @override
  AppointmentType fromJson(data) => AppointmentType.fromJson(data);
}
