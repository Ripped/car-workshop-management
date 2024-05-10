import 'package:cwm_desktop_mobile/models/appointment.dart';
import 'package:cwm_desktop_mobile/providers/base_provider.dart';

import '../models/searches/appointment_search.dart';

class AppointmentProvider extends BaseProvider<Appointment, AppointmentSearch> {
  @override
  Appointment fromJson(data) => Appointment.fromJson(data);
}
