import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/data_table_sources/work_order_data_table_source.dart';
import 'package:cwm_desktop_mobile/providers/work_order_provider.dart';
import 'package:cwm_desktop_mobile/screens/work_order_closure_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:cwm_desktop_mobile/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkOrderListScreen extends StatefulWidget {
  const WorkOrderListScreen({super.key});

  @override
  State<WorkOrderListScreen> createState() => _WorkOrderListScreenState();
}

class _WorkOrderListScreenState extends State<WorkOrderListScreen> {
  late WorkOrderProvider _workOrderProvider;

  late WorkOrderListDataTableSource workOrderListDataTableSource;

  @override
  void initState() {
    super.initState();

    _workOrderProvider = context.read<WorkOrderProvider>();
    workOrderListDataTableSource =
        WorkOrderListDataTableSource(_workOrderProvider, _openDetails);
  }

  void _openDetails(int? id) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            MasterScreen("Detalji o nalogu", WorkOrderClosureScreen(id))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search(
          "Dodaj nalog",
          () => _openDetails(null),
          onSearch: (text) => workOrderListDataTableSource.filterData(text),
          hideButton: true,
        ),
        SizedBox(
          width: double.infinity,
          child: AdvancedPaginatedDataTable(
            showHorizontalScrollbarAlways: Responsive.isMobile(context),
            addEmptyRows: false,
            showCheckboxColumn: false,
            source: workOrderListDataTableSource,
            rowsPerPage: 7,
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
