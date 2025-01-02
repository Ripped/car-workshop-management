import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:cwm_desktop_mobile/components/exstension.dart';
import 'package:cwm_desktop_mobile/models/appointment.dart';
import 'package:cwm_desktop_mobile/models/searches/appointment_search.dart';
import 'package:cwm_desktop_mobile/providers/appointment_provider.dart';
import 'package:flutter/material.dart';

class AppointmentListDataTableSource
    extends AdvancedDataTableSource<Appointment> {
  final AppointmentProvider _appointmentProvider;
  final Function(int) _onSelectChanged;

  var appointmentSearch = AppointmentSearch();

  AppointmentListDataTableSource(
      this._appointmentProvider, this._onSelectChanged);

  @override
  Future<RemoteDataSourceDetails<Appointment>> getNextPage(
      NextPageRequest pageRequest) async {
    var page =
        (pageRequest.offset / pageRequest.pageSize).roundToDouble().ceil();

    appointmentSearch.page = page + 1;
    appointmentSearch.pageSize = pageRequest.pageSize;
    appointmentSearch.includeAppointmentType = true;

    var appointment =
        await _appointmentProvider.getAll(search: appointmentSearch);

    return RemoteDataSourceDetails(appointment.totalCount, appointment.result);
  }

  @override
  DataRow? getRow(int index) {
    final currentRow = lastDetails!.rows[index];
    return DataRow(
      onSelectChanged: (e) => _onSelectChanged(currentRow.id),
      cells: [
        DataCell(Text(currentRow.description)),
        DataCell(Text(currentRow.startDate.toString())),
        DataCell(Text(currentRow.endDate.toString())),
        DataCell(
          SizedBox.expand(
            // Use container to fill the background color
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              color: HexColor(currentRow.appointmentType!.color),

              // Align text to middle
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  currentRow.appointmentType!.name,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  int get selectedRowCount => 0;

  Future filterData(String? name) async {
    appointmentSearch.serviceName = name;
    setNextView();
  }
}
