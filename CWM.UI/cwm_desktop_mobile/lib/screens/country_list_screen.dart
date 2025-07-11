import 'package:advanced_datatable/datatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../data_table_sources/country_data_table_source.dart';
import '../providers/country_provider.dart';
import '../widgets/responsive.dart';
import '../widgets/search.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  late CountryProvider _countryProvider;

  late CountryDataTableSource countryDataTableSource;

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    _countryProvider = context.read<CountryProvider>();

    countryDataTableSource =
        CountryDataTableSource(_countryProvider, _openDialog);

    _loadData(null);
  }

  Future _loadData(int? id) async {
    if (id != null) {
      var country = await _countryProvider.get(id);

      _formKey.currentState?.patchValue({"name": country.name});
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
        Search("Dodaj državu", () => _openDialog(null),
            onSearch: (text) => countryDataTableSource.filterData(text)),
        SizedBox(
          width: double.infinity,
          child: AdvancedPaginatedDataTable(
            showHorizontalScrollbarAlways: Responsive.isMobile(context),
            addEmptyRows: false,
            showCheckboxColumn: false,
            source: countryDataTableSource,
            rowsPerPage: 7,
            columns: const [DataColumn(label: Text("Naziv"))],
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
            Text(id == null ? "Dodaj državu" : "Uredi državu"),
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
                      validator: FormBuilderValidators.required(
                          errorText: "Naziv je obavezan."),
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
                await _countryProvider.delete(id);
                countryDataTableSource.filterData(null);
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
                              "* Ova država je referencirana od pojedinih gradova, te zbog toga ne može biti obrisana. Molimo prvo obrišite gradove koji referenciraju ovu državu.",
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
                  ? await _countryProvider.insert(request)
                  : await _countryProvider.update(id, request);

              countryDataTableSource.filterData(null);
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
