import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/data_table_sources/expenses_data_table_source.dart';
import 'package:cwm_desktop_mobile/models/employee.dart';
import 'package:cwm_desktop_mobile/providers/employee_provider.dart';
import 'package:cwm_desktop_mobile/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../models/paged_result.dart';
import '../widgets/responsive.dart';
import '../widgets/search.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  late ExpensesProvider _expensesProvider;
  late EmployeeProvider _employeeProvider;

  late ExpensesDataTableSource expensesDataTableSource;

  final _formKey = GlobalKey<FormBuilderState>();
  var _employees = PagedResult<Employee>();

  @override
  void initState() {
    super.initState();
    _expensesProvider = context.read<ExpensesProvider>();
    _employeeProvider = context.read<EmployeeProvider>();

    expensesDataTableSource =
        ExpensesDataTableSource(_expensesProvider, _openDialog);

    _loadData(null);
  }

  Future _loadData(int? id) async {
    _employees = await _employeeProvider.getAll();
    if (id != null) {
      var expenses = await _expensesProvider.get(id);

      _formKey.currentState?.patchValue({
        "description": expenses.description,
        "date": expenses.date,
        "employeeId": expenses.employee?.id.toString() ?? "0",
        "totalAmount": expenses.totalAmount.toString(),
        "expensesType": expenses.expensesType.index
      });
    }
  }

  void _openDialog(int? id) {
    if (Responsive.isMobile(context)) return;

    showDialog(
      context: context,
      builder: (BuildContext context) => _buildDialog(context, id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search("Dodaj utrosak", () => _openDialog(null),
            onSearch: (text) => expensesDataTableSource.filterData(text)),
        SizedBox(
          width: double.infinity,
          child: AdvancedPaginatedDataTable(
            showHorizontalScrollbarAlways: Responsive.isMobile(context),
            addEmptyRows: false,
            showCheckboxColumn: false,
            source: expensesDataTableSource,
            rowsPerPage: 7,
            columns: const [
              DataColumn(label: Text("Datum")),
              DataColumn(label: Text("Total")),
              DataColumn(label: Text("Vrsta utroska"))
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDialog(BuildContext context, int? id) {
    _loadData(id);

    return AlertDialog(
      title: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(id == null ? Icons.add : Icons.edit),
            const SizedBox(width: 10),
            Text(id == null ? "Dodaj utrosak" : "Uredi utrosak"),
          ],
        ),
      ),
      content: FormBuilder(
        key: _formKey,
        child: SizedBox(
          height: 300,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderTextField(
                      name: "description",
                      decoration: const InputDecoration(labelText: "Opis *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Opis je obavezan."),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderTextField(
                      name: "totalAmount",
                      decoration: const InputDecoration(labelText: "Cijena *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Cijena je obavezna."),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderDateTimePicker(
                      name: "date",
                      decoration: const InputDecoration(labelText: "Datum *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Datum je obavezan."),
                    ),
                  ),
                ],
              ),
              Row(children: [
                SizedBox(
                  width: 500,
                  child: FormBuilderDropdown(
                    name: "expensesType",
                    decoration:
                        const InputDecoration(labelText: "Vrsta servisa *"),
                    validator: FormBuilderValidators.required(
                        errorText: "Vrsta je obavezna."),
                    items: const [
                      DropdownMenuItem(
                        value: 0,
                        child: Text("Licenca"),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text("Edukacija"),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text("Hrana"),
                      ),
                      DropdownMenuItem(
                        value: 3,
                        child: Text("Plata"),
                      ),
                    ],
                  ),
                ),
              ]),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderDropdown(
                      name: "employeeId",
                      decoration:
                          const InputDecoration(labelText: "Uposlenik *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Uposlenik je obavezan."),
                      items: _employees.result
                          .map((employee) => DropdownMenuItem(
                                value: employee.id.toString(),
                                child: Text(employee.firstName),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.all(20),
      buttonPadding: const EdgeInsets.all(20),
      actions: [
        if (id != null)
          OutlinedButton(
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(Colors.red),
              padding: const WidgetStatePropertyAll(
                EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 20),
              ),
            ),
            child: const Text("OBRIŠI"),
            onPressed: () async {
              try {
                await _expensesProvider.delete(id);
                expensesDataTableSource.filterData(null);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red[800],
                      showCloseIcon: false,
                      duration: Durations.extralong4,
                      content: const Text("Podaci su obrisani"),
                    ),
                  );
                  Navigator.pop(context);
                }
              } catch (error) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: SizedBox(
                        width: 400,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "* Ne možete obrisati ovaj utrosak.",
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        const SizedBox(width: 185),
        OutlinedButton(
          style: const ButtonStyle(
            padding: WidgetStatePropertyAll(
              EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 20),
            ),
          ),
          child: const Text("NAZAD"),
          onPressed: () => Navigator.pop(context),
        ),
        OutlinedButton(
          style: const ButtonStyle(
            padding: WidgetStatePropertyAll(
              EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 20),
            ),
          ),
          child: const Text("SPREMI"),
          onPressed: () async {
            var isValid = _formKey.currentState?.saveAndValidate();

            if (isValid!) {
              var request = Map.from(_formKey.currentState!.value);

              id == null
                  ? await _expensesProvider.insert(request)
                  : await _expensesProvider.update(id, request);

              expensesDataTableSource.filterData(null);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green[800],
                    showCloseIcon: false,
                    duration: Durations.extralong4,
                    content: const Text("Podaci su spremljeni"),
                  ),
                );
                Navigator.pop(context);
              }
            }
          },
        ),
      ],
    );
  }
}
