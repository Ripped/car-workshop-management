import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:cwm_desktop_mobile/models/appointment_type.dart';
import 'package:cwm_desktop_mobile/models/searches/appointment_type_search.dart';
import 'package:cwm_desktop_mobile/providers/appointment_type_provider.dart';
import 'package:flutter/material.dart';

class AppointmentTypeDataTableSource
    extends AdvancedDataTableSource<AppointmentType> {
  final AppointmentTypeProvider _appointmentTypeProvider;
  final Function(int) _onSelectChanged;

  var appointmentTypeSearch = AppointmentTypeSearch();

  AppointmentTypeDataTableSource(
      this._appointmentTypeProvider, this._onSelectChanged);

  @override
  Future<RemoteDataSourceDetails<AppointmentType>> getNextPage(
      NextPageRequest pageRequest) async {
    var page =
        (pageRequest.offset / pageRequest.pageSize).roundToDouble().ceil();

    appointmentTypeSearch.page = page + 1;
    appointmentTypeSearch.pageSize = pageRequest.pageSize;

    var appointmentTypes =
        await _appointmentTypeProvider.getAll(search: appointmentTypeSearch);

    return RemoteDataSourceDetails(
        appointmentTypes.totalCount, appointmentTypes.result);
  }

  @override
  DataRow? getRow(int index) {
    final currentRow = lastDetails!.rows[index];
    return DataRow(
      onSelectChanged: (e) => _onSelectChanged(currentRow.id),
      cells: [
        DataCell(Text(currentRow.name)),
        DataCell(Text(currentRow.color)),
      ],
    );
  }

  @override
  int get selectedRowCount => 0;

  Future filterData(String? name) async {
    appointmentTypeSearch.name = name;
    setNextView();
  }
}
