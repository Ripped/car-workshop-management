import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:cwm_desktop_mobile/models/searches/user_search.dart';
import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:cwm_desktop_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';

class UserDataTableSource extends AdvancedDataTableSource<User> {
  final UserProvider _userProvider;
  final Function(int) _onSelectChanged;

  var userSearch = UserSearch();

  UserDataTableSource(this._userProvider, this._onSelectChanged);

  @override
  Future<RemoteDataSourceDetails<User>> getNextPage(
      NextPageRequest pageRequest) async {
    var page =
        (pageRequest.offset / pageRequest.pageSize).roundToDouble().ceil();

    userSearch.page = page + 1;
    userSearch.pageSize = pageRequest.pageSize;

    var users = await _userProvider.getAll(search: userSearch);

    return RemoteDataSourceDetails(users.totalCount, users.result);
  }

  @override
  DataRow? getRow(int index) {
    final currentRow = lastDetails!.rows[index];
    return DataRow(
      onSelectChanged: (e) => _onSelectChanged(currentRow.id),
      cells: [
        DataCell(Text(currentRow.firstName.toString())),
        DataCell(Text(currentRow.lastName.toString())),
        DataCell(Text(currentRow.email.toString())),
      ],
    );
  }

  @override
  int get selectedRowCount => 0;

  Future filterData(String? name) async {
    userSearch.name = name;
    setNextView();
  }
}
