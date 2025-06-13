import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_table_sources/vehicle_list_data_table_source.dart';
import '../providers/vehicle_provider.dart';
import 'vehicle_history_list_screen.dart';

class VehicleListScreen extends StatefulWidget {
  const VehicleListScreen({super.key});

  @override
  State<VehicleListScreen> createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  late VehicleProvider _vehicleOrderProvider;

  late VehicleListDataTableSource vehicleListDataTableSource;

  @override
  void initState() {
    super.initState();

    _vehicleOrderProvider = context.read<VehicleProvider>();
    vehicleListDataTableSource =
        VehicleListDataTableSource(_vehicleOrderProvider, _openDetails);
  }

  void _openDetails(int? id) {
    //if (Responsive.isMobile(context)) return;

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            MasterScreen("Historija vozila", VehicleHistoryListScreen(id))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: AdvancedPaginatedDataTable(
            showHorizontalScrollbarAlways: Responsive.isMobile(context),
            addEmptyRows: false,
            showCheckboxColumn: false,
            source: vehicleListDataTableSource,
            rowsPerPage: 10,
            columns: const [
              DataColumn(label: Text("Serial number")),
              DataColumn(label: Text("Service performed")),
              DataColumn(label: Text("Start date")),
              DataColumn(label: Text("End date")),
            ],
          ),
        )
      ],
    );
  }
}
