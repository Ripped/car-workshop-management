import 'package:cwm_desktop_mobile/providers/base_provider.dart';
import '../models/searches/work_order_search.dart';
import '../models/work_order.dart';

class WorkOrderProvider extends BaseProvider<WorkOrder, WorkOrderSearch> {
  @override
  WorkOrder fromJson(data) => WorkOrder.fromJson(data);
}
