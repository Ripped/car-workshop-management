import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:cwm_desktop_mobile/models/vehicle_service_history.dart';
import 'package:cwm_desktop_mobile/providers/vehicle_service_history_provider.dart';
import 'package:flutter/material.dart';
import '../models/searches/vehicle_service_history_search.dart';

class VehicleHistoryListDataTableSource
    extends AdvancedDataTableSource<VehicleServiceHistory> {
  final VehicleServiceHistoryProvider _vehicleServiceHistoryProvider;
  final Function(int) _onSelectChanged;

  var vehicleServiceHistorySearch = VehicleServiceHistorySearch();

  VehicleHistoryListDataTableSource(this._vehicleServiceHistoryProvider,
      this._onSelectChanged, this.vehicleServiceHistorySearch);

  @override
  Future<RemoteDataSourceDetails<VehicleServiceHistory>> getNextPage(
      NextPageRequest pageRequest) async {
    var page =
        (pageRequest.offset / pageRequest.pageSize).roundToDouble().ceil();

    vehicleServiceHistorySearch.page = page + 1;
    vehicleServiceHistorySearch.pageSize = pageRequest.pageSize;
    vehicleServiceHistorySearch.includeVehicle = true;

    var vehicleServiceHistory = await _vehicleServiceHistoryProvider.getAll(
        search: vehicleServiceHistorySearch);

    return RemoteDataSourceDetails(
        vehicleServiceHistory.totalCount, vehicleServiceHistory.result);
  }

  @override
  DataRow? getRow(int index) {
    final currentRow = lastDetails!.rows[index];
    return DataRow(
      onSelectChanged: (e) => _onSelectChanged(currentRow.id),
      cells: [
        DataCell(Text(currentRow.serviceDate.toString())),
      ],
    );
  }

  @override
  int get selectedRowCount => 0;

  Future filterData(String? name) async {
    vehicleServiceHistorySearch.name = name;
    setNextView();
  }
}
