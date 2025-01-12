import 'package:cwm_desktop_mobile/providers/base_provider.dart';

import '../models/searches/user_search.dart';
import '../models/user.dart';

class UserProvider extends BaseProvider<User, UserSearch> {
  @override
  User fromJson(data) => User.fromJson(data);
}
