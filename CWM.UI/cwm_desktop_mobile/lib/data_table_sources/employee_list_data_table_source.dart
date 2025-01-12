import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:cwm_desktop_mobile/models/employee.dart';
import 'package:cwm_desktop_mobile/providers/employee_provider.dart';
import 'package:flutter/material.dart';
import '../models/searches/employee_search.dart';

class EmployeeListDataTableSource extends AdvancedDataTableSource<Employee> {
  final EmployeeProvider _employeeProvider;
  final Function(int) _onSelectChanged;

  var employeeSearch = EmployeeSearch();

  EmployeeListDataTableSource(this._employeeProvider, this._onSelectChanged);

  @override
  Future<RemoteDataSourceDetails<Employee>> getNextPage(
      NextPageRequest pageRequest) async {
    var page =
        (pageRequest.offset / pageRequest.pageSize).roundToDouble().ceil();

    employeeSearch.page = page + 1;
    employeeSearch.pageSize = pageRequest.pageSize;

    var employee = await _employeeProvider.getAll(search: employeeSearch);

    return RemoteDataSourceDetails(employee.totalCount, employee.result);
  }

  @override
  DataRow? getRow(int index) {
    final currentRow = lastDetails!.rows[index];
    return DataRow(
      onSelectChanged: (e) => _onSelectChanged(currentRow.id),
      cells: [
        DataCell(Text(currentRow.firstName)),
        DataCell(Text(currentRow.lastName)),
        DataCell(Text(currentRow.mobile.toString())),
        DataCell(Text(currentRow.email.toString())),
      ],
    );
  }

  @override
  int get selectedRowCount => 0;

  Future filterData(String? name) async {
    employeeSearch.name = name;
    setNextView();
  }
}
