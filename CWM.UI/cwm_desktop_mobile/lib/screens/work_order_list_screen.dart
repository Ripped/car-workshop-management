import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/data_table_sources/work_order_data_table_source.dart';
import 'package:cwm_desktop_mobile/providers/work_order_provider.dart';
import 'package:cwm_desktop_mobile/screens/work_order_closure_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WorkOrderListScreen extends StatefulWidget {
  const WorkOrderListScreen({super.key});

  @override
  State<WorkOrderListScreen> createState() => _WorkOrderListScreenState();
}

class _WorkOrderListScreenState extends State<WorkOrderListScreen> {
  late WorkOrderListDataTableSource workOrderListDataTableSource;

  @override
  void initState() {
    super.initState();

    var workOrderProvider = context.read<WorkOrderProvider>();
    workOrderListDataTableSource =
        WorkOrderListDataTableSource(workOrderProvider, _openDetails);
  }

  void _openDetails(int? id) {
    if (Responsive.isMobile(context)) return;

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            MasterScreen("Detalji o dijelu", WorkOrderClosureScreen(id))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*Search(
          "Dodaj novi dio",
          () => _openDetails(null),
          onSearch: (text) => appointmentListDataTableSource.filterData(text),
        ),*/
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
