import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:cwm_desktop_mobile/components/exstension.dart';
import 'package:cwm_desktop_mobile/models/searches/work_order_search.dart';
import 'package:cwm_desktop_mobile/models/work_order.dart';
import 'package:flutter/material.dart';
import '../models/enums/role.dart';
import '../providers/work_order_provider.dart';
import '../utils/utils.dart';

class CustomerWorkOrderListDataTableSource
    extends AdvancedDataTableSource<WorkOrder> {
  final WorkOrderProvider _workOrderProvider;
  final Function(int) _onSelectChanged;

  var workOrderSearch = WorkOrderSearch();

  CustomerWorkOrderListDataTableSource(
      this._workOrderProvider, this._onSelectChanged);

  @override
  Future<RemoteDataSourceDetails<WorkOrder>> getNextPage(
      NextPageRequest pageRequest) async {
    var page =
        (pageRequest.offset / pageRequest.pageSize).roundToDouble().ceil();

    workOrderSearch.page = page + 1;
    workOrderSearch.pageSize = pageRequest.pageSize;
    workOrderSearch.includeVehicle = true;

    if (Authorization.roles.contains(Role.employee)) {
      workOrderSearch.employeeUsername = Authorization.username;
    }
    if (Authorization.roles.contains(Role.user)) {
      workOrderSearch.employeeUsername = Authorization.username;
    }

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
        DataCell(Text(currentRow.total.toString())),
        DataCell(Text(currentRow.startTime.toString())),
        DataCell(
          SizedBox.expand(
            // Use container to fill the background color
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              color: currentRow.payment ? Colors.green : Colors.red,

              // Align text to middle
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  currentRow.payment ? "Placeno" : "Nije placeno",
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
    workOrderSearch.name = name;
    setNextView();
  }
}
