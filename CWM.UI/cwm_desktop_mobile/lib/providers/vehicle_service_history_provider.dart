import 'package:cwm_desktop_mobile/models/searches/vehicle_service_history_search.dart';
import 'package:cwm_desktop_mobile/models/vehicle_service_history.dart';
import 'package:cwm_desktop_mobile/providers/base_provider.dart';

class VehicleServiceHistoryProvider
    extends BaseProvider<VehicleServiceHistory, VehicleServiceHistorySearch> {
  @override
  VehicleServiceHistory fromJson(data) => VehicleServiceHistory.fromJson(data);
}
