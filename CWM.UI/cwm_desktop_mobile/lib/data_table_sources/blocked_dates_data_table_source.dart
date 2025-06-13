import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:cwm_desktop_mobile/models/appointment_blocked.dart';
import 'package:cwm_desktop_mobile/models/searches/appointment_blocked_search.dart';
import 'package:cwm_desktop_mobile/providers/appointment_blocked_provider.dart';
import 'package:flutter/material.dart';

class BlockedDatesDataTableSource
    extends AdvancedDataTableSource<AppointmentBlocked> {
  final AppointmentBlockedProvider _appointmentBlockedProvider;
  final Function(int) _onSelectChanged;

  var appointmentBlockedSearch = AppointmentBlockedSearch();

  BlockedDatesDataTableSource(
      this._appointmentBlockedProvider, this._onSelectChanged);

  @override
  Future<RemoteDataSourceDetails<AppointmentBlocked>> getNextPage(
      NextPageRequest pageRequest) async {
    var page =
        (pageRequest.offset / pageRequest.pageSize).roundToDouble().ceil();

    appointmentBlockedSearch.page = page + 1;
    appointmentBlockedSearch.pageSize = pageRequest.pageSize;

    var appointmentBlocked = await _appointmentBlockedProvider.getAll(
        search: appointmentBlockedSearch);

    return RemoteDataSourceDetails(
        appointmentBlocked.totalCount, appointmentBlocked.result);
  }

  @override
  DataRow? getRow(int index) {
    final currentRow = lastDetails!.rows[index];
    return DataRow(
      onSelectChanged: (e) => _onSelectChanged(currentRow.id),
      cells: [
        DataCell(Text(currentRow.blockedDate.toString())),
      ],
    );
  }

  @override
  int get selectedRowCount => 0;

  Future filterData(DateTime? date) async {
    appointmentBlockedSearch.blockedDate = date;
    setNextView();
  }
}
