import 'package:cwm_desktop_mobile/providers/base_provider.dart';

import '../models/part.dart';
import '../models/searches/part_search.dart';

class PartProvider extends BaseProvider<Part, PartSearch> {
  @override
  Part fromJson(data) => Part.fromJson(data);
}
