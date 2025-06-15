import 'package:cwm_desktop_mobile/models/employee.dart';
import 'package:cwm_desktop_mobile/models/enums/role.dart';
import 'package:cwm_desktop_mobile/models/paged_result.dart';
import 'package:cwm_desktop_mobile/models/searches/employee_search.dart';
import 'package:cwm_desktop_mobile/models/searches/vehicle_search.dart';
import 'package:cwm_desktop_mobile/models/vehicle.dart';
import 'package:cwm_desktop_mobile/providers/employee_provider.dart';
import 'package:cwm_desktop_mobile/providers/vehicle_provider.dart';
import 'package:cwm_desktop_mobile/screens/vehicle_list.dart';
import 'package:cwm_desktop_mobile/utils/utils.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../providers/vehicle_service_history_provider.dart';

class VehicleServiceHistoryDetailsScreen extends StatefulWidget {
  final int? id;
  const VehicleServiceHistoryDetailsScreen(this.id, {super.key});

  @override
  State<VehicleServiceHistoryDetailsScreen> createState() =>
      _VehicleServiceHistoryDetailsScreenScreen();
}

class _VehicleServiceHistoryDetailsScreenScreen
    extends State<VehicleServiceHistoryDetailsScreen> {
  late VehicleServiceHistoryProvider _vehicleServiceHistoryProvider;
  late VehicleProvider _vehicleProvider;
  late EmployeeProvider _employeeProvider;

  bool isLoading = true;
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  var _employees = PagedResult<Employee>();
  var _vehicles = PagedResult<Vehicle>();

  @override
  void initState() {
    super.initState();

    _vehicleServiceHistoryProvider =
        context.read<VehicleServiceHistoryProvider>();
    _vehicleProvider = context.read<VehicleProvider>();
    _employeeProvider = context.read<EmployeeProvider>();

    _loadData(widget.id);
  }

  Future _loadData(int? id) async {
    var vehicleSearch = VehicleSearch();
    var employeeSearch = EmployeeSearch();
    if (id != null) {
      var vehicleServiceHistory = await _vehicleServiceHistoryProvider.get(id);
      vehicleSearch.name = vehicleServiceHistory.vehicle!.chassis;
      employeeSearch.name = vehicleServiceHistory.employee!.firstName;

      _initialValue = {
        "serviceType": vehicleServiceHistory.serviceType.index,
        "serviceDate": vehicleServiceHistory.serviceDate,
        "description": vehicleServiceHistory.description,
        "sugestions": vehicleServiceHistory.sugestions,
        "vehicleId": vehicleServiceHistory.vehicle?.id,
        "employeeId": vehicleServiceHistory.employee?.id
      };
      _vehicles = await _vehicleProvider.getAll(search: vehicleSearch);
      _employees = await _employeeProvider.getAll(search: employeeSearch);
    } else {
      _initialValue = {"image": "", "description": ""};
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: isLoading
            ? Container()
            : FormBuilder(
                key: _formKey,
                initialValue: _initialValue,
                child: SizedBox(
                    child: Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 2,
                        child: Column(
                          children: [
                            Card(
                              margin: const EdgeInsets.all(10),
                              color: Theme.of(context).primaryColor,
                              child: SizedBox(
                                width: (MediaQuery.of(context).size.width),
                                height: 30,
                                child: Text(
                                  "Pregled historije vozila",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Responsive.isDesktop(context)
                                  ? (MediaQuery.of(context).size.width / 2.8)
                                  : (MediaQuery.of(context).size.height / 1.4),
                              child: GridView.count(
                                crossAxisCount: Responsive.isDesktop(context)
                                    ? 3
                                    : Responsive.isTablet(context)
                                        ? 2
                                        : 1,
                                padding: const EdgeInsets.all(20),
                                childAspectRatio: 4,
                                crossAxisSpacing: 20,
                                children: [
                                  //const SizedBox(height: 20),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: SizedBox(
                                      width: 300,
                                      child: FormBuilderDropdown(
                                        enabled: Authorization.roles
                                                .contains(Role.admin)
                                            ? true
                                            : false,
                                        name: "serviceType",
                                        decoration: const InputDecoration(
                                            labelText: "Vrsta servisa *"),
                                        items: const [
                                          DropdownMenuItem(
                                            value: 0,
                                            child: Text("Elektrika"),
                                          ),
                                          DropdownMenuItem(
                                            value: 1,
                                            child: Text("Mehanicar"),
                                          ),
                                          DropdownMenuItem(
                                            value: 2,
                                            child: Text("Limarija"),
                                          ),
                                          DropdownMenuItem(
                                            value: 3,
                                            child: Text("Podvozje"),
                                          ),
                                          DropdownMenuItem(
                                            value: 4,
                                            child: Text("Pregled"),
                                          ),
                                          DropdownMenuItem(
                                            value: 5,
                                            child: Text("Ostalo"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: SizedBox(
                                      width: 290,
                                      child: FormBuilderDropdown(
                                        enabled: Authorization.roles
                                                .contains(Role.admin)
                                            ? true
                                            : false,
                                        name: "employeeId",
                                        decoration: const InputDecoration(
                                            labelText: "Uposlenik *"),
                                        items: _employees.result
                                            .map((type) => DropdownMenuItem(
                                                  value: type.id,
                                                  child: Text(
                                                      "${type.firstName} ${type.lastName}"),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: SizedBox(
                                      width: 290,
                                      child: FormBuilderDropdown(
                                        enabled: Authorization.roles
                                                .contains(Role.admin)
                                            ? true
                                            : false,
                                        name: "vehicleId",
                                        decoration: const InputDecoration(
                                            labelText: "Vozilo *"),
                                        items: _vehicles.result
                                            .map((type) => DropdownMenuItem(
                                                  value: type.id,
                                                  child: Text(type.chassis),
                                                ))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: FormBuilderDateTimePicker(
                                        enabled: Authorization.roles
                                                .contains(Role.admin)
                                            ? true
                                            : false,
                                        name: "serviceDate",
                                        decoration: const InputDecoration(
                                            labelText:
                                                "Datum rada na vozilu *"),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: FormBuilderTextField(
                                        enabled: Authorization.roles
                                                .contains(Role.admin)
                                            ? true
                                            : false,
                                        name: "description",
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 3,
                                        decoration: const InputDecoration(
                                            labelText:
                                                "Opis kvara vlasnika vozila  *"),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: FormBuilderTextField(
                                        enabled: Authorization.roles
                                                .contains(Role.admin)
                                            ? true
                                            : false,
                                        name: "sugestions",
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 3,
                                        decoration: const InputDecoration(
                                            labelText:
                                                "Prijedlog za vlasnika *"),
                                      ),
                                    ),
                                  ),

                                  /*if (Responsive.isDesktop(context))
                                    const Padding(
                                        padding: EdgeInsets.only(left: 350.0)),*/
                                  const SizedBox(height: 20),
                                  if (Authorization.roles.contains(Role.admin))
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: ElevatedButton(
                                        style: const ButtonStyle(
                                            minimumSize: WidgetStatePropertyAll(
                                                Size.fromHeight(50))),
                                        child: const Text("SPREMI",
                                            textAlign: TextAlign.center),
                                        onPressed: () async {
                                          var isValid = _formKey.currentState
                                              ?.saveAndValidate();

                                          if (isValid!) {
                                            var request = Map.from(
                                                _formKey.currentState!.value);

                                            widget.id == null
                                                ? await _vehicleServiceHistoryProvider
                                                    .insert(request)
                                                : await _vehicleServiceHistoryProvider
                                                    .update(
                                                        widget.id!, request);

                                            if (context.mounted) {
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MasterScreen(
                                                              "Historija vozila",
                                                              VehicleListScreen())));
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      /*Column(
                      children: [
                        _basicInfo(context),
                      ],
                    )*/
                    )
                  ],
                )),
              ));
  }

  /*Widget _basicInfo(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            color: Theme.of(context).primaryColor,
            child: const SizedBox(
              width: 800,
              height: 30,
              child: Text(
                "Pregled historije vozila",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: Responsive.isDesktop(context)
                ? (MediaQuery.of(context).size.width / 5)
                : 200,
            child: GridView.count(
              crossAxisCount: Responsive.isDesktop(context)
                  ? 3
                  : Responsive.isTablet(context)
                      ? 2
                      : 1,
              padding: const EdgeInsets.all(20),
              childAspectRatio: 4,
              crossAxisSpacing: 20,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FormBuilderDateTimePicker(
                      name: "serviceDate",
                      decoration: const InputDecoration(
                          labelText: "Datum rada na vozilu *"),
                    ),
                  ),
                ),
                //const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: SizedBox(
                    width: 300,
                    child: FormBuilderDropdown(
                      name: "servicePerformed",
                      decoration:
                          const InputDecoration(labelText: "Vrsta servisa *"),
                      items: const [
                        DropdownMenuItem(
                          value: 0,
                          child: Text("Elektrika"),
                        ),
                        DropdownMenuItem(
                          value: 1,
                          child: Text("Mehanicar"),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: Text("Limarija"),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: Text("Podvozje"),
                        ),
                        DropdownMenuItem(
                          value: 4,
                          child: Text("Pregled"),
                        ),
                        DropdownMenuItem(
                          value: 5,
                          child: Text("Ostalo"),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: SizedBox(
                    width: 290,
                    child: FormBuilderDropdown(
                      name: "employeeId",
                      decoration:
                          const InputDecoration(labelText: "Uposlenik *"),
                      items: _employees.result
                          .map((type) => DropdownMenuItem(
                                value: type.id,
                                child:
                                    Text("${type.firstName} ${type.lastName}"),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: SizedBox(
                    width: 290,
                    child: FormBuilderDropdown(
                      enabled: false,
                      name: "vehicleId",
                      decoration: const InputDecoration(labelText: "Vozilo *"),
                      items: _vehicles.result
                          .map((type) => DropdownMenuItem(
                                value: type.id,
                                child: Text(type.chassis),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FormBuilderTextField(
                      name: "description",
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: const InputDecoration(
                          labelText: "Opis kvara vlasnika vozila  *"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FormBuilderTextField(
                      name: "sugestion",
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration: const InputDecoration(
                          labelText: "Prijedlog za vlasnika *"),
                    ),
                  ),
                ),

                if (Responsive.isDesktop(context))
                  const Padding(padding: EdgeInsets.only(left: 350.0)),
                Container(
                    width: 300,
                    padding: const EdgeInsets.all(20),
                    child: Column(children: <Widget>[
                      ElevatedButton(
                        style: const ButtonStyle(
                            minimumSize:
                                WidgetStatePropertyAll(Size.fromHeight(50))),
                        child:
                            const Text("SPREMI", textAlign: TextAlign.center),
                        onPressed: () async {
                          var isValid =
                              _formKey.currentState?.saveAndValidate();

                          if (isValid!) {
                            var request =
                                Map.from(_formKey.currentState!.value);

                            widget.id == null
                                ? await _vehicleServiceHistoryProvider
                                    .insert(request)
                                : await _vehicleServiceHistoryProvider.update(
                                    widget.id!, request);

                            if (context.mounted) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const MasterScreen(
                                          "Historija vozila",
                                          VehicleListScreen())));
                            }
                          }
                        },
                      ),
                    ])),
              ],
            ),
          ),
        ],
      ),
    );
  }*/
}
