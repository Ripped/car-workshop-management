import 'package:cwm_desktop_mobile/models/part_work_order.dart';
import 'package:cwm_desktop_mobile/providers/base_provider.dart';
import '../models/searches/part_work_order_search.dart';

class PartWorkOrderProvider
    extends BaseProvider<PartWorkOrder, PartWorkOrderSearch> {
  @override
  PartWorkOrder fromJson(data) => PartWorkOrder.fromJson(data);
}
