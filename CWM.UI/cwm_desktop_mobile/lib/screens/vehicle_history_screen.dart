import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:cwm_desktop_mobile/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_table_sources/vehicle_history_list_data_table_source.dart';
import '../models/searches/vehicle_service_history_search.dart';
import '../providers/vehicle_service_history_provider.dart';
import 'vehicle_service_history_details_screen.dart';

class VehicleHistoryScreen extends StatefulWidget {
  final int? vehicleId;
  const VehicleHistoryScreen(this.vehicleId, {super.key});

  @override
  State<VehicleHistoryScreen> createState() => _VehicleHistoryScreenState();
}

class _VehicleHistoryScreenState extends State<VehicleHistoryScreen> {
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
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MasterScreen(
            "Detalji o vozilu", VehicleServiceHistoryDetailsScreen(id))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search(
          "Dodaj historiju",
          () => _openDetails(null),
          onSearch: (text) =>
              vehicleServiceHistoryDataTableSource.filterData(text),
          hideButton: true,
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
              DataColumn(label: Text("Start date")),
            ],
          ),
        )
      ],
    );
  }
}
