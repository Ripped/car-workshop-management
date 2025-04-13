import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/providers/work_order_provider.dart';
import 'package:cwm_desktop_mobile/screens/customer_order_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_table_sources/work_order_data_table_source.dart';

class CustomerOrderListScreen extends StatefulWidget {
  const CustomerOrderListScreen({super.key});

  @override
  State<CustomerOrderListScreen> createState() =>
      _CustomerOrderListScreenState();
}

class _CustomerOrderListScreenState extends State<CustomerOrderListScreen> {
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
    //if (Responsive.isMobile(context)) return;

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            MasterScreen("Detalji o dijelu", CustomerOrderScreen(id))));
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
