import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:cwm_desktop_mobile/models/searches/work_order_search.dart';
import 'package:cwm_desktop_mobile/models/work_order.dart';
import 'package:flutter/material.dart';
import '../providers/work_order_provider.dart';

class WorkOrderListDataTableSource extends AdvancedDataTableSource<WorkOrder> {
  final WorkOrderProvider _workOrderProvider;
  final Function(int) _onSelectChanged;

  var workOrderSearch = WorkOrderSearch();

  WorkOrderListDataTableSource(this._workOrderProvider, this._onSelectChanged);

  @override
  Future<RemoteDataSourceDetails<WorkOrder>> getNextPage(
      NextPageRequest pageRequest) async {
    var page =
        (pageRequest.offset / pageRequest.pageSize).roundToDouble().ceil();

    workOrderSearch.page = page + 1;
    workOrderSearch.pageSize = pageRequest.pageSize;
    workOrderSearch.includeVehicle = true;

    var workOrder = await _workOrderProvider.getAll(search: workOrderSearch);

    return RemoteDataSourceDetails(workOrder.totalCount, workOrder.result);
  }

  @override
  DataRow? getRow(int index) {
    final currentRow = lastDetails!.rows[index];
    return DataRow(
      onSelectChanged: (e) => _onSelectChanged(currentRow.id),
      cells: [
        DataCell(Text(currentRow.orderNumber)),
        DataCell(Text(currentRow.concerne)),
        DataCell(Text(currentRow.startTime.toString())),
        DataCell(Text(currentRow.endTime.toString())),
      ],
    );
  }

  @override
  int get selectedRowCount => 0;

  Future filterData(String? name) async {
    workOrderSearch.name = name;
    setNextView();
  }
}
