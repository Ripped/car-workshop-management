import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/appointment.dart' as appointment;

class AppointmentDataTableSource extends CalendarDataSource {
  AppointmentDataTableSource(List<appointment.Appointment> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].startDate;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].endDate;
  }

  @override
  String getSubject(int index) {
    return appointments![index].servicePerformed.toString();
  }

  /*@override
  Color getColor(int index) {
    var rgbColor =
        appointments![index].appointmentType.color.replaceFirst('#', '0xff');
    return Color(int.parse(rgbColor.toString()));
  }*/

  /*@override
  bool isAllDay(int index) {
    return true;
  }*/
}
