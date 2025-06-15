import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/data_table_sources/vehicle_list_data_table_source.dart';
import 'package:cwm_desktop_mobile/providers/vehicle_provider.dart';
import 'package:cwm_desktop_mobile/screens/vehicle_details_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/responsive.dart';
import '../widgets/search.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
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
            MasterScreen("Detalji o vozilu", VehicleDetailsScreen(id))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search("Dodaj vozilo", () => _openDetails(null),
            onSearch: (text) => vehicleListDataTableSource.filterData(text)),
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
