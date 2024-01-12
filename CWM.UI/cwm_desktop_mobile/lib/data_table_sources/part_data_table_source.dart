import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:flutter/material.dart';

import '../models/part.dart';
import '../models/searches/part_search.dart';
import '../providers/part_provider.dart';

class PartDataTableSource extends AdvancedDataTableSource<Part> {
  final PartProvider _partProvider;
  final Function(int) _onSelectChanged;

  var partSearch = PartSearch();

  PartDataTableSource(this._partProvider, this._onSelectChanged);

  @override
  Future<RemoteDataSourceDetails<Part>> getNextPage(
      NextPageRequest pageRequest) async {
    var page =
        (pageRequest.offset / pageRequest.pageSize).roundToDouble().ceil();

    partSearch.page = page + 1;
    partSearch.pageSize = pageRequest.pageSize;

    var parts = await _partProvider.getAll(search: partSearch);

    return RemoteDataSourceDetails(parts.totalCount, parts.result);
  }

  @override
  DataRow? getRow(int index) {
    final currentRow = lastDetails!.rows[index];
    return DataRow(
      onSelectChanged: (e) => _onSelectChanged(currentRow.id),
      cells: [
        DataCell(Text(currentRow.serialNumber)),
        DataCell(Text(currentRow.manufacturer)),
        DataCell(Text(currentRow.partName)),
        //DataCell(Text(currentRow.image)),
        DataCell(Text("${currentRow.price} KM")),
        //DataCell(Text(currentRow.description)),
      ],
    );
  }

  @override
  int get selectedRowCount => 0;

  Future filterData(String? name) async {
    partSearch.name = name;
    setNextView();
  }
}
