import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/data_table_sources/customer_work_order_data_table_source.dart';
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

  late CustomerWorkOrderListDataTableSource workOrderListDataTableSource;

  @override
  void initState() {
    super.initState();

    _workOrderProvider = context.read<WorkOrderProvider>();
    workOrderListDataTableSource =
        CustomerWorkOrderListDataTableSource(_workOrderProvider, _openDetails);
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
              DataColumn(label: Text("Order number")),
              DataColumn(label: Text("Total for service")),
              DataColumn(label: Text("Service date")),
              DataColumn(label: Text("Payment")),
            ],
          ),
        )
      ],
    );
  }
}
