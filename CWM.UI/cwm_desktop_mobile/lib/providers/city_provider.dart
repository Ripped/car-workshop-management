import 'package:cwm_desktop_mobile/models/city.dart';
import 'package:cwm_desktop_mobile/providers/base_provider.dart';

import '../models/searches/city_search.dart';

class CityProvider extends BaseProvider<City, CitySearch> {
  @override
  City fromJson(data) => City.fromJson(data);
}
