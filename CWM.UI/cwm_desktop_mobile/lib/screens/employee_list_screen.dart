import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/screens/employee_details_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:cwm_desktop_mobile/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data_table_sources/employee_list_data_table_source.dart';
import '../providers/employee_provider.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  late EmployeeProvider _employeeProvider;

  late EmployeeListDataTableSource employeeListDataTableSource;

  @override
  void initState() {
    super.initState();

    _employeeProvider = context.read<EmployeeProvider>();
    employeeListDataTableSource =
        EmployeeListDataTableSource(_employeeProvider, _openDetails);
  }

  void _openDetails(int? id) {
    //if (Responsive.isMobile(context)) return;

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            MasterScreen("Detalji o uposleniku", EmployeeDetailsScreen(id))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search(
          "Dodaj uposlenika",
          () => _openDetails(null),
          onSearch: (text) => employeeListDataTableSource.filterData(text),
        ),
        SizedBox(
          width: double.infinity,
          child: AdvancedPaginatedDataTable(
            showHorizontalScrollbarAlways: Responsive.isMobile(context),
            addEmptyRows: false,
            showCheckboxColumn: false,
            source: employeeListDataTableSource,
            rowsPerPage: 7,
            columns: const [
              DataColumn(label: Text("Ime")),
              DataColumn(label: Text("Prezime")),
              DataColumn(label: Text("Broj mobitela")),
              DataColumn(label: Text("Email")),
            ],
          ),
        )
      ],
    );
  }
}
