import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:cwm_desktop_mobile/models/enums/role.dart';
import 'package:cwm_desktop_mobile/models/vehicle.dart';
import 'package:cwm_desktop_mobile/providers/vehicle_provider.dart';
import 'package:cwm_desktop_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import '../models/searches/vehicle_search.dart';

class VehicleListDataTableSource extends AdvancedDataTableSource<Vehicle> {
  final VehicleProvider _vehicleOrderProvider;
  final Function(int) _onSelectChanged;

  var vehicleSearch = VehicleSearch();

  VehicleListDataTableSource(this._vehicleOrderProvider, this._onSelectChanged);

  @override
  Future<RemoteDataSourceDetails<Vehicle>> getNextPage(
      NextPageRequest pageRequest) async {
    var page =
        (pageRequest.offset / pageRequest.pageSize).roundToDouble().ceil();

    vehicleSearch.page = page + 1;
    vehicleSearch.pageSize = pageRequest.pageSize;
    vehicleSearch.includeServiceHistory = true;
    if (Authorization.roles.contains(Role.user) ||
        Authorization.roles.contains(Role.employee)) {
      vehicleSearch.userId = Authorization.userId;
    }

    var vehicle = await _vehicleOrderProvider.getAll(search: vehicleSearch);

    return RemoteDataSourceDetails(vehicle.totalCount, vehicle.result);
  }

  @override
  DataRow? getRow(int index) {
    final currentRow = lastDetails!.rows[index];
    return DataRow(
      onSelectChanged: (e) => _onSelectChanged(currentRow.id),
      cells: [
        DataCell(Text(currentRow.chassis)),
        DataCell(Text(currentRow.brand)),
        DataCell(Text(currentRow.model)),
        DataCell(Text(currentRow.fuel)),
      ],
    );
  }

  @override
  int get selectedRowCount => 0;

  Future filterData(String? name) async {
    vehicleSearch.name = name;
    setNextView();
  }
}
