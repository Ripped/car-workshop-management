import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/providers/part_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_table_sources/part_data_table_source.dart';
import '../widgets/master_screen.dart';
import '../widgets/responsive.dart';
import '../widgets/search.dart';
import 'part_details_screen.dart';

class PartListScreen extends StatefulWidget {
  const PartListScreen({super.key});

  @override
  State<PartListScreen> createState() => _PartListScreenState();
}

class _PartListScreenState extends State<PartListScreen> {
  late PartDataTableSource partDataTableSource;

  @override
  void initState() {
    super.initState();

    var partProvider = context.read<PartProvider>();
    partDataTableSource = PartDataTableSource(partProvider, _openDetails);
  }

  void _openDetails(int? id) {
    if (Responsive.isMobile(context)) return;

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            MasterScreen("Detalji o dijelu", PartDetailsScreen(id))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search(
          "Dodaj novi dio",
          () => _openDetails(null),
          onSearch: (text) => partDataTableSource.filterData(text),
        ),
        SizedBox(
          width: double.infinity,
          child: AdvancedPaginatedDataTable(
            showHorizontalScrollbarAlways: Responsive.isMobile(context),
            addEmptyRows: false,
            showCheckboxColumn: false,
            source: partDataTableSource,
            rowsPerPage: 7,
            columns: const [
              DataColumn(label: Text("Serial number")),
              DataColumn(label: Text("Manufacturer")),
              DataColumn(label: Text("Part name")),
              DataColumn(label: Text("Price")),
            ],
          ),
        )
      ],
    );
  }
}
