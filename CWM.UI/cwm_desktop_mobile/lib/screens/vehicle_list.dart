import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/screens/vehicle_details_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:cwm_desktop_mobile/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_table_sources/vehicle_list_data_table_source.dart';
import '../providers/vehicle_provider.dart';

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
            MasterScreen("Detalji vozila", VehicleDetailsScreen(id))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search(
          "Dodaj novo vozilo",
          hideSearch: false,
          () => _openDetails(null),
          onSearch: (text) => vehicleListDataTableSource.filterData(text),
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
        )
      ],
    );
  }
}
