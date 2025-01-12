import 'package:cwm_desktop_mobile/providers/base_provider.dart';

import '../models/employee.dart';
import '../models/searches/employee_search.dart';

class EmployeeProvider extends BaseProvider<Employee, EmployeeSearch> {
  @override
  Employee fromJson(data) => Employee.fromJson(data);
}
