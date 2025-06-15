import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/data_table_sources/blocked_dates_data_table_source.dart';
import 'package:cwm_desktop_mobile/providers/appointment_blocked_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../widgets/responsive.dart';
import '../widgets/search.dart';

class BlockedDatesScreen extends StatefulWidget {
  const BlockedDatesScreen({super.key});

  @override
  State<BlockedDatesScreen> createState() => _BlockedDatesScreenState();
}

class _BlockedDatesScreenState extends State<BlockedDatesScreen> {
  late AppointmentBlockedProvider _appointmentBlockedProvider;

  late BlockedDatesDataTableSource appointmentBlockedDataTableSource;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    _appointmentBlockedProvider = context.read<AppointmentBlockedProvider>();

    appointmentBlockedDataTableSource =
        BlockedDatesDataTableSource(_appointmentBlockedProvider, _openDialog);

    _loadData(null);
  }

  Future _loadData(int? id) async {
    if (id != null) {
      var appointmentType = await _appointmentBlockedProvider.get(id);

      _formKey.currentState?.patchValue({
        "blockedDate": appointmentType.blockedDate,
      });
    }
  }

  Future<void> _selectedDate() async {
    DateTime? selected = await showDatePicker(
        context: context, firstDate: DateTime(1900), lastDate: DateTime(2100));
    if (selected != null) {
      setState(() {
        appointmentBlockedDataTableSource.filterData(selected);
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
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(Colors.green),
              minimumSize: WidgetStatePropertyAll(Size.fromHeight(50))),
          onPressed: () {
            _selectedDate();
          },
          child: Text(
            "Izaberi datum pretrage",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Search(
          "Dodaj novi datum",
          () => _openDialog(null),
          hideSearch: true,
        ),
        SizedBox(
          width: double.infinity,
          child: AdvancedPaginatedDataTable(
            showHorizontalScrollbarAlways: Responsive.isMobile(context),
            addEmptyRows: false,
            showCheckboxColumn: false,
            source: appointmentBlockedDataTableSource,
            rowsPerPage: 7,
            columns: const [
              DataColumn(label: Text("Datum blokiran")),
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
            Text(id == null ? "Dodaj novi datum" : "Uredi datum"),
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
                    child: FormBuilderDateTimePicker(
                      name: "blockedDate",
                      decoration:
                          const InputDecoration(labelText: "Datum blokiran *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Datum je obavezan."),
                    ),
                  )
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
                await _appointmentBlockedProvider.delete(id);
                appointmentBlockedDataTableSource.filterData(null);
                if (context.mounted) Navigator.pop(context);
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
                              "* Ne možete obrisati ovaj datum.",
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
                  ? await _appointmentBlockedProvider.insert(request)
                  : await _appointmentBlockedProvider.update(id, request);

              appointmentBlockedDataTableSource.filterData(null);
              if (context.mounted) Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
