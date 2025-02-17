import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/data_table_sources/appointment_list_data_table_source.dart';
import 'package:cwm_desktop_mobile/providers/appointment_provider.dart';
import 'package:cwm_desktop_mobile/screens/work_order_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppointmentListScreen extends StatefulWidget {
  const AppointmentListScreen({super.key});

  @override
  State<AppointmentListScreen> createState() => _AppointmentListScreenState();
}

class _AppointmentListScreenState extends State<AppointmentListScreen> {
  late AppointmentProvider _appointmentProvider;

  late AppointmentListDataTableSource appointmentListDataTableSource;

  @override
  void initState() {
    super.initState();

    _appointmentProvider = context.read<AppointmentProvider>();
    appointmentListDataTableSource =
        AppointmentListDataTableSource(_appointmentProvider, _openDetails);
  }

  void _openDetails(int? id) {
    //if (Responsive.isMobile(context)) return;

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            MasterScreen("Detalji o dijelu", WorkOrderScreen(id))));
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
            source: appointmentListDataTableSource,
            rowsPerPage: 10,
            columns: const [
              DataColumn(label: Text("Serial number")),
              DataColumn(label: Text("Start date")),
              DataColumn(label: Text("End date")),
              DataColumn(label: Text("Status")),
            ],
          ),
        )
      ],
    );
  }
}
