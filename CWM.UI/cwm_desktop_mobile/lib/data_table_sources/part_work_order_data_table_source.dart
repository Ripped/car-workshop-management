import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:cwm_desktop_mobile/models/part_work_order.dart';
import 'package:cwm_desktop_mobile/models/searches/part_work_order_search.dart';
import 'package:cwm_desktop_mobile/providers/part_work_order_provider.dart';
import 'package:cwm_desktop_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

class PartWorkOrderDataTableSource
    extends AdvancedDataTableSource<PartWorkOrder> {
  final PartWorkOrderProvider _partWorkOrderProvider;
  final Function(int) _onSelectChanged;

  var partWorkOrderSearch = PartWorkOrderSearch();

  PartWorkOrderDataTableSource(
      this._partWorkOrderProvider, this._onSelectChanged);

  @override
  Future<RemoteDataSourceDetails<PartWorkOrder>> getNextPage(
      NextPageRequest pageRequest) async {
    var page =
        (pageRequest.offset / pageRequest.pageSize).roundToDouble().ceil();

    partWorkOrderSearch.page = page + 1;
    partWorkOrderSearch.pageSize = pageRequest.pageSize;
    partWorkOrderSearch.userId = Authorization.userId;
    partWorkOrderSearch.includePart = true;

    var partWorkOrder =
        await _partWorkOrderProvider.getAll(search: partWorkOrderSearch);

    return RemoteDataSourceDetails(
        partWorkOrder.totalCount, partWorkOrder.result);
  }

  @override
  DataRow? getRow(int index) {
    final currentRow = lastDetails!.rows[index];
    return DataRow(
      onSelectChanged: (e) => _onSelectChanged(currentRow.id),
      cells: [
        DataCell(Text(currentRow.part!.partName)),
        DataCell(Text(currentRow.part!.manufacturer)),
        DataCell(Text(currentRow.part!.price.toString())),
      ],
    );
  }

  @override
  int get selectedRowCount => 0;

  Future filterData(DateTime? date) async {
    partWorkOrderSearch.serviceDate = date;
    setNextView();
  }
}
