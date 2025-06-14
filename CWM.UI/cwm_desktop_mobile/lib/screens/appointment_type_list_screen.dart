import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/data_table_sources/appointment_type_data_table_source.dart';
import 'package:cwm_desktop_mobile/providers/appointment_type_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../widgets/responsive.dart';
import '../widgets/search.dart';

class AppointmentTypeListScreen extends StatefulWidget {
  const AppointmentTypeListScreen({super.key});

  @override
  State<AppointmentTypeListScreen> createState() =>
      _AppointmentTypeListScreenState();
}

class _AppointmentTypeListScreenState extends State<AppointmentTypeListScreen> {
  late AppointmentTypeProvider _appointmentTypeProvider;

  late AppointmentTypeDataTableSource appointmentTypeDataTableSource;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    _appointmentTypeProvider = context.read<AppointmentTypeProvider>();

    appointmentTypeDataTableSource =
        AppointmentTypeDataTableSource(_appointmentTypeProvider, _openDialog);

    _loadData(null);
  }

  Future _loadData(int? id) async {
    if (id != null) {
      var appointmentType = await _appointmentTypeProvider.get(id);

      _formKey.currentState?.patchValue({
        "name": appointmentType.name,
        "color": appointmentType.color,
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
        Search("Dodaj vrstu termina", () => _openDialog(null),
            onSearch: (text) =>
                appointmentTypeDataTableSource.filterData(text)),
        SizedBox(
          width: double.infinity,
          child: AdvancedPaginatedDataTable(
            showHorizontalScrollbarAlways: Responsive.isMobile(context),
            addEmptyRows: false,
            showCheckboxColumn: false,
            source: appointmentTypeDataTableSource,
            rowsPerPage: 7,
            columns: const [
              DataColumn(label: Text("Naziv")),
              DataColumn(label: Text("Boja"))
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
            Text(id == null ? "Dodaj vrstu termina" : "Uredi vrstu termina"),
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
                      name: "name",
                      decoration: const InputDecoration(labelText: "Naziv *"),
                      /*validator: FormBuilderValidators.required(
                          errorText: "Naziv je obavezan."),*/
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderTextField(
                      name: "color",
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(labelText: "Boja"),
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
              foregroundColor: MaterialStateProperty.all(Colors.red),
              padding: const MaterialStatePropertyAll(
                EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 20),
              ),
            ),
            child: const Text("OBRIŠI"),
            onPressed: () async {
              try {
                await _appointmentTypeProvider.delete(id);
                appointmentTypeDataTableSource.filterData(null);
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
                              "* Ne možete obrisati ovu vrstu termina.",
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
            padding: MaterialStatePropertyAll(
              EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 20),
            ),
          ),
          child: const Text("NAZAD"),
          onPressed: () => Navigator.pop(context),
        ),
        OutlinedButton(
          style: const ButtonStyle(
            padding: MaterialStatePropertyAll(
              EdgeInsets.only(left: 40, top: 20, right: 40, bottom: 20),
            ),
          ),
          child: const Text("SPREMI"),
          onPressed: () async {
            var isValid = _formKey.currentState?.saveAndValidate();

            if (isValid!) {
              var request = Map.from(_formKey.currentState!.value);

              id == null
                  ? await _appointmentTypeProvider.insert(request)
                  : await _appointmentTypeProvider.update(id, request);

              appointmentTypeDataTableSource.filterData(null);
              if (context.mounted) Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
