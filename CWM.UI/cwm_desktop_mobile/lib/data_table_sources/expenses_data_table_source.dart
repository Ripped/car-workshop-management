import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:cwm_desktop_mobile/models/expenses.dart';
import 'package:cwm_desktop_mobile/models/searches/expenses_search.dart';
import 'package:cwm_desktop_mobile/providers/expenses_provider.dart';
import 'package:flutter/material.dart';

class ExpensesDataTableSource extends AdvancedDataTableSource<Expenses> {
  final ExpensesProvider _expensesProvider;
  final Function(int) _onSelectChanged;

  var expensesSearch = ExpensesSearch();

  ExpensesDataTableSource(this._expensesProvider, this._onSelectChanged);

  @override
  Future<RemoteDataSourceDetails<Expenses>> getNextPage(
      NextPageRequest pageRequest) async {
    var page =
        (pageRequest.offset / pageRequest.pageSize).roundToDouble().ceil();

    expensesSearch.page = page + 1;
    expensesSearch.pageSize = pageRequest.pageSize;

    var expenses = await _expensesProvider.getAll(search: expensesSearch);

    return RemoteDataSourceDetails(expenses.totalCount, expenses.result);
  }

  @override
  DataRow? getRow(int index) {
    final currentRow = lastDetails!.rows[index];
    return DataRow(
      onSelectChanged: (e) => _onSelectChanged(currentRow.id),
      cells: [
        DataCell(Text(currentRow.description)),
        DataCell(Text(currentRow.date.toString())),
        DataCell(Text(currentRow.totalAmount.toString())),
        DataCell(Text(currentRow.expensesType.name)),
      ],
    );
  }

  @override
  int get selectedRowCount => 0;

  Future filterData(String? name) async {
    expensesSearch.description = name;
    setNextView();
  }
}
