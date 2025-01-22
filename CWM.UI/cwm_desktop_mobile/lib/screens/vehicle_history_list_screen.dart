import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_table_sources/vehicle_history_list_data_table_source.dart';
import '../models/searches/vehicle_service_history_search.dart';
import '../providers/vehicle_service_history_provider.dart';
import '../widgets/search.dart';
import 'vehicle_service_history_details_screen.dart';

class VehicleHistoryListScreen extends StatefulWidget {
  final int? vehicleId;
  const VehicleHistoryListScreen(this.vehicleId, {super.key});

  @override
  State<VehicleHistoryListScreen> createState() =>
      _VehicleHistoryListScreenState();
}

class _VehicleHistoryListScreenState extends State<VehicleHistoryListScreen> {
  late VehicleServiceHistoryProvider _vehicleServiceHistoryProvider;
  var vehicleServiceHistorySearch = VehicleServiceHistorySearch();
  late VehicleHistoryListDataTableSource vehicleServiceHistoryDataTableSource;

  @override
  void initState() {
    super.initState();
    _vehicleServiceHistoryProvider =
        context.read<VehicleServiceHistoryProvider>();
    vehicleServiceHistorySearch.vehicleId = widget.vehicleId;
    vehicleServiceHistoryDataTableSource = VehicleHistoryListDataTableSource(
        _vehicleServiceHistoryProvider,
        _openDetails,
        vehicleServiceHistorySearch);
  }

  void _openDetails(int? id) {
    if (Responsive.isMobile(context)) return;

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MasterScreen(
            "Detalji o dijelu", VehicleServiceHistoryDetailsScreen(id))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search(
          "Dodaj novi Nalog",
          () => _openDetails(null),
          onSearch: (text) =>
              vehicleServiceHistoryDataTableSource.filterData(text),
        ),
        SizedBox(
          width: double.infinity,
          child: AdvancedPaginatedDataTable(
            showHorizontalScrollbarAlways: Responsive.isMobile(context),
            addEmptyRows: false,
            showCheckboxColumn: false,
            source: vehicleServiceHistoryDataTableSource,
            rowsPerPage: 10,
            columns: const [
              /*DataColumn(label: Text("Serial number")),
              DataColumn(label: Text("Service performed")),*/
              DataColumn(label: Text("Start date")),
            ],
          ),
        )
      ],
    );
  }
}
