import 'package:cwm_desktop_mobile/models/searches/user_role_search.dart';
import 'package:cwm_desktop_mobile/models/user_role.dart';
import 'package:cwm_desktop_mobile/providers/base_provider.dart';

class UserRoleProvider extends BaseProvider<UserRole, UserRoleSearch> {
  @override
  UserRole fromJson(data) => UserRole.fromJson(data);
}
