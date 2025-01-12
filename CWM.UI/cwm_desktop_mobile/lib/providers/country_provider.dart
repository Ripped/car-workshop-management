import 'package:cwm_desktop_mobile/providers/base_provider.dart';

import '../models/country.dart';
import '../models/searches/country_search.dart';

class CountryProvider extends BaseProvider<Country, CountrySearch> {
  @override
  Country fromJson(data) => Country.fromJson(data);
}
