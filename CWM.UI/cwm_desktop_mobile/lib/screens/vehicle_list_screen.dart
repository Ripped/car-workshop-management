import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/data_table_sources/vehicle_list_data_table_source.dart';
import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:cwm_desktop_mobile/providers/user_provider.dart';
import 'package:cwm_desktop_mobile/providers/vehicle_provider.dart';
import 'package:cwm_desktop_mobile/screens/vehicle_details_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/paged_result.dart';
import '../widgets/responsive.dart';
import '../widgets/search.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  late VehicleProvider _vehicleProvider;
  late UserProvider _userProvider;

  late VehicleListDataTableSource vehicleListDataTableSource;

  final _formKey = GlobalKey<FormBuilderState>();
  var _users = PagedResult<User>();

  @override
  void initState() {
    super.initState();

    _vehicleProvider = context.read<VehicleProvider>();
    _userProvider = context.read<UserProvider>();

    vehicleListDataTableSource =
        VehicleListDataTableSource(_vehicleProvider, _openDetails);

    _loadData(null);
  }

  Future _loadData(int? id) async {
    _users = await _userProvider.getAll();

    if (id != null) {
      var vehicle = await _vehicleProvider.get(id);

      _formKey.currentState?.patchValue({
        "chassis": vehicle.chassis,
        "brand": vehicle.brand,
        "model": vehicle.model,
        "cubicCapacity": vehicle.cubicCapacity.toString(),
        "kilowatts": vehicle.kilowatts.toString(),
        "transmision": vehicle.transmision,
        "productionDate": vehicle.productionDate.toString(),
        "fuel": vehicle.fuel,
        "userId": vehicle.user!.id.toString()
      });
    }
  }

  void _openDetails(int? id) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            MasterScreen("Detalji o vozilu", VehicleDetailsScreen(id))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search("Dodaj vozilo", () => _openDetails(null),
            onSearch: (text) => vehicleListDataTableSource.filterData(text)),
        SizedBox(
          width: double.infinity,
          child: AdvancedPaginatedDataTable(
            showHorizontalScrollbarAlways: Responsive.isMobile(context),
            addEmptyRows: false,
            showCheckboxColumn: false,
            source: vehicleListDataTableSource,
            rowsPerPage: 7,
            columns: const [
              DataColumn(label: Text("Sasija")),
              DataColumn(label: Text("Marka vozila")),
              DataColumn(label: Text("Model vozila")),
              DataColumn(label: Text("Gorivo")),
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
            Text(id == null ? "Dodaj grad" : "Uredi grad"),
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
                      name: "chassis",
                      decoration: const InputDecoration(labelText: "Sasija *"),
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
                      name: "brand",
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration:
                          const InputDecoration(labelText: "Brend vozila"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderTextField(
                      name: "model",
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration:
                          const InputDecoration(labelText: "Model vozila"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderTextField(
                      name: "cubicCapacity",
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(labelText: "Kubika"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderTextField(
                      name: "kilowatts",
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(labelText: "Kilovati"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderTextField(
                      name: "transmision",
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(labelText: "Mjenjac"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderTextField(
                      name: "productionDate",
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration:
                          const InputDecoration(labelText: "Datum proizvodnje"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderTextField(
                      name: "fuel",
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(labelText: "Gorivo"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderDropdown(
                      name: "userId",
                      decoration:
                          const InputDecoration(labelText: "Korisnik *"),
                      items: _users.result
                          .map((user) => DropdownMenuItem(
                                value: user.id.toString(),
                                child:
                                    Text("${user.firstName} ${user.lastName}"),
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
                await _vehicleProvider.delete(id);
                vehicleListDataTableSource.filterData(null);
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
                              "* Ne možete obrisati ovaj grad.",
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
                  ? await _vehicleProvider.insert(request)
                  : await _vehicleProvider.update(id, request);

              vehicleListDataTableSource.filterData(null);
              if (context.mounted) Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
