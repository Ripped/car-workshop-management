import 'package:cwm_desktop_mobile/models/enums/role.dart';
import 'package:intl/intl.dart';

class Authorization {
  static int? userId;
  static String? username;
  static String? password;
  static List<Role> roles = [];
}

String formatNumber(dynamic) {
  var f = NumberFormat('###.00');

  if (dynamic == null) {
    return "";
  }
  return f.format(dynamic);
}

String formatDate(dynamic) {
  var f = DateFormat('yyyy-MM-dd HH:mm');

  if (dynamic == null) {
    return "";
  }

  return f.format(dynamic);
}

String formatDate1(dynamic) {
  var f = DateFormat('MMMM d y');

  if (dynamic == null) {
    return "";
  }

  return f.format(dynamic);
}
