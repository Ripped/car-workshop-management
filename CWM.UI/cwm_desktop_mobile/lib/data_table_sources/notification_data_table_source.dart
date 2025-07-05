import 'package:advanced_datatable/advanced_datatable_source.dart';
import 'package:cwm_desktop_mobile/models/searches/notification_search.dart';
import 'package:cwm_desktop_mobile/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:cwm_desktop_mobile/models/notification.dart' as notification;

class NotificationDataTableSource
    extends AdvancedDataTableSource<notification.Notification> {
  final NotificationProvider _notificationProvider;
  final Function(int) _onSelectChanged;

  var notificationSearch = NotificationSearch();

  NotificationDataTableSource(
      this._notificationProvider, this._onSelectChanged);

  @override
  Future<RemoteDataSourceDetails<notification.Notification>> getNextPage(
      NextPageRequest pageRequest) async {
    var page =
        (pageRequest.offset / pageRequest.pageSize).roundToDouble().ceil();

    notificationSearch.page = page + 1;
    notificationSearch.pageSize = pageRequest.pageSize;
    notificationSearch.includeUser = true;

    var notifications =
        await _notificationProvider.getAll(search: notificationSearch);

    return RemoteDataSourceDetails(
        notifications.totalCount, notifications.result);
  }

  @override
  DataRow? getRow(int index) {
    final currentRow = lastDetails!.rows[index];
    return DataRow(
      onSelectChanged: (e) => _onSelectChanged(currentRow.id),
      cells: [
        DataCell(Text(currentRow.name)),
        DataCell(Text(currentRow.user!.firstName)),
        DataCell(Text(currentRow.user!.lastName)),
      ],
    );
  }

  @override
  int get selectedRowCount => 0;

  Future filterData(String? name) async {
    notificationSearch.name = name;
    setNextView();
  }
}
