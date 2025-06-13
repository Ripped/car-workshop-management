import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:cwm_desktop_mobile/models/searches/user_role_search.dart';
import 'package:cwm_desktop_mobile/models/user_role.dart';
import 'package:cwm_desktop_mobile/providers/user_role_provider.dart';
import 'package:flutter/material.dart';

class UserRoleDataTableSource extends AdvancedDataTableSource<UserRole> {
  final UserRoleProvider _userRoleProvider;
  final Function(int) _onSelectChanged;

  var userRoleSearch = UserRoleSearch();

  UserRoleDataTableSource(this._userRoleProvider, this._onSelectChanged);

  @override
  Future<RemoteDataSourceDetails<UserRole>> getNextPage(
      NextPageRequest pageRequest) async {
    var page =
        (pageRequest.offset / pageRequest.pageSize).roundToDouble().ceil();

    userRoleSearch.page = page + 1;
    userRoleSearch.pageSize = pageRequest.pageSize;
    userRoleSearch.includeUser = true;

    var userRoles = await _userRoleProvider.getAll(search: userRoleSearch);

    return RemoteDataSourceDetails(userRoles.totalCount, userRoles.result);
  }

  @override
  DataRow? getRow(int index) {
    final currentRow = lastDetails!.rows[index];
    return DataRow(
      onSelectChanged: (e) => _onSelectChanged(currentRow.id),
      cells: [
        DataCell(Text(currentRow.role.name)),
        DataCell(Text(currentRow.user!.firstName)),
        DataCell(Text(currentRow.user!.lastName)),
      ],
    );
  }

  @override
  int get selectedRowCount => 0;

  Future filterData(String? name) async {
    userRoleSearch.userUsername = name;
    setNextView();
  }
}
