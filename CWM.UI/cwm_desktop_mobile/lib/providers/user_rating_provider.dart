import 'package:cwm_desktop_mobile/models/searches/user_rating_search.dart';
import 'package:cwm_desktop_mobile/models/user_rating.dart';
import 'package:cwm_desktop_mobile/providers/base_provider.dart';

class UserRatingProvider extends BaseProvider<UserRating, UserRatingSearch> {
  @override
  UserRating fromJson(data) => UserRating.fromJson(data);
}
