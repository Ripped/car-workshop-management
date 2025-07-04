import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/data_table_sources/vehicle_list_data_table_source.dart';
import 'package:cwm_desktop_mobile/providers/vehicle_provider.dart';
import 'package:cwm_desktop_mobile/screens/vehicle_history_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/responsive.dart';

class VehicleHistoryListScreen extends StatefulWidget {
  const VehicleHistoryListScreen({super.key});

  @override
  State<VehicleHistoryListScreen> createState() =>
      _VehicleHistoryListScreenState();
}

class _VehicleHistoryListScreenState extends State<VehicleHistoryListScreen> {
  late VehicleProvider _vehicleProvider;

  late VehicleListDataTableSource vehicleListDataTableSource;

  @override
  void initState() {
    super.initState();

    _vehicleProvider = context.read<VehicleProvider>();

    vehicleListDataTableSource =
        VehicleListDataTableSource(_vehicleProvider, _openDetails);
  }

  void _openDetails(int? id) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            MasterScreen("Historija vozila", VehicleHistoryScreen(id))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search(
          "Dodaj historiju",
          () => _openDetails(null),
          onSearch: (text) => vehicleListDataTableSource.filterData(text),
          hideButton: true,
        ),
        SizedBox(
          width: double.infinity,
          child: AdvancedPaginatedDataTable(
            showHorizontalScrollbarAlways: Responsive.isMobile(context),
            addEmptyRows: false,
            showCheckboxColumn: false,
            source: vehicleListDataTableSource,
            rowsPerPage: 7,
            columns: const [
              DataColumn(label: Text("Sasija")),
              DataColumn(label: Text("Marka vozila")),
              DataColumn(label: Text("Model vozila")),
              DataColumn(label: Text("Gorivo")),
            ],
          ),
        ),
      ],
    );
  }
}
