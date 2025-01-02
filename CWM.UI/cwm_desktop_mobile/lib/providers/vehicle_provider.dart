import 'package:cwm_desktop_mobile/models/searches/vehicle_search.dart';
import 'package:cwm_desktop_mobile/models/vehicle.dart';
import 'package:cwm_desktop_mobile/providers/base_provider.dart';

class VehicleProvider extends BaseProvider<Vehicle, VehicleSearch> {
  @override
  Vehicle fromJson(data) => Vehicle.fromJson(data);
}
