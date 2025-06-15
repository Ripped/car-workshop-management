import 'package:cwm_desktop_mobile/models/appointment.dart';
import 'package:cwm_desktop_mobile/models/employee.dart';
import 'package:cwm_desktop_mobile/models/part.dart';
import 'package:cwm_desktop_mobile/models/searches/part_search.dart';
import 'package:cwm_desktop_mobile/models/searches/part_work_order_search.dart';
import 'package:cwm_desktop_mobile/models/searches/vehicle_search.dart';
import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:cwm_desktop_mobile/providers/appointment_provider.dart';
import 'package:cwm_desktop_mobile/providers/employee_provider.dart';
import 'package:cwm_desktop_mobile/providers/part_provider.dart';
import 'package:cwm_desktop_mobile/providers/part_work_order_provider.dart';
import 'package:cwm_desktop_mobile/providers/work_order_provider.dart';
import 'package:cwm_desktop_mobile/screens/work_order_list_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/paged_result.dart';
import '../models/vehicle.dart';
import '../providers/user_provider.dart';
import '../providers/vehicle_provider.dart';

class WorkOrderClosureScreen extends StatefulWidget {
  final int? id;
  const WorkOrderClosureScreen(this.id, {super.key});

  @override
  State<WorkOrderClosureScreen> createState() => _WorkOrderClosureScreen();
}

class _WorkOrderClosureScreen extends State<WorkOrderClosureScreen> {
  late WorkOrderProvider _workOrderProvider;
  late PartWorkOrderProvider _partWorkOrderProvider;
  late AppointmentProvider _appointmentProvider;
  late VehicleProvider _vehicleProvider;
  late UserProvider _userProvider;
  late EmployeeProvider _employeeProvider;
  late PartProvider _partProvider;

  bool isLoading = true;
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  var _parts = PagedResult<Part>();
  var _appointments = PagedResult<Appointment>();
  var _vehicles = PagedResult<Vehicle>();
  var _employees = PagedResult<Employee>();
  var _users = PagedResult<User>();
  late int? _partWorkOrderId;
  var parts = <Part>[];
  bool payment = false;
  Map<Part, bool> partsList = {};
  Map<dynamic, dynamic> mapOfPartWorkOrder = {};
  List<Map<dynamic, dynamic>> tempPartsWorkOrderList = [];

  @override
  void initState() {
    super.initState();

    _workOrderProvider = context.read<WorkOrderProvider>();
    _appointmentProvider = context.read<AppointmentProvider>();
    _partWorkOrderProvider = context.read<PartWorkOrderProvider>();
    _partProvider = context.read<PartProvider>();
    _userProvider = context.read<UserProvider>();
    _employeeProvider = context.read<EmployeeProvider>();
    _vehicleProvider = context.read<VehicleProvider>();
    _partWorkOrderId = null;
    _loadData(widget.id);
  }

  void searchParts(PartSearch partSearch) async {
    _parts = await _partProvider.getAll(search: partSearch);
    parts = _parts.result;

    partsList.clear();
    if (parts.isNotEmpty) {
      for (var part in parts) {
        for (var p in partsList.keys) {
          if (p.id == part.id) return;
        }
        partsList[part] = false;
      }
    }
  }

  void _addParts() async {
    var workOrder = await _workOrderProvider.get(widget.id!);
    for (var i in partsList.entries) {
      if (i.value) {
        Map<dynamic, dynamic> temp = {
          "serviceDate": workOrder.startTime,
          "vehicleId": workOrder.vehicle!.id,
          "workOrderId": workOrder.id,
          "partId": i.key.id
        };
        tempPartsWorkOrderList.add(temp);
      }
    }
    for (var i in tempPartsWorkOrderList) {
      _partWorkOrderId == null
          ? await _partWorkOrderProvider.insert(i)
          : await _partWorkOrderProvider.update(_partWorkOrderId!, i);
    }
  }

  void _openDialog(int? id) {
    _loadData(id).then((data) {
      showDialog(
        context: context,
        builder: (BuildContext context) => _buildDialog(context),
      );
    });
  }

  Future _loadData(int? id) async {
    var partWorkOrderSearch = PartWorkOrderSearch();
    var vehicleSearch = VehicleSearch();
    vehicleSearch.pageSize = 50;

    _vehicles = await _vehicleProvider.getAll(search: vehicleSearch);
    _appointments = await _appointmentProvider.getAll();
    _users = await _userProvider.getAll();
    _employees = await _employeeProvider.getAll();
    _parts = await _partProvider.getAll();
    parts = _parts.result;

    for (var part in parts) {
      for (var p in partsList.keys) {
        if (p.id == part.id) return;
      }
      partsList[part] = false;
    }

    if (id != null) {
      var workOrder = await _workOrderProvider.get(id);

      partWorkOrderSearch.serviceDate = workOrder.startTime;
      partWorkOrderSearch.vehicleId = workOrder.vehicle?.id;
      var partWorkorder =
          await _partWorkOrderProvider.getAll(search: partWorkOrderSearch);
      if (partWorkorder.result.isNotEmpty) {
        _partWorkOrderId = partWorkorder.result.first.id;
      }

      _initialValue = {
        "orderNumber": workOrder.orderNumber,
        "total": workOrder.total.toString(),
        "serviceType": workOrder.servicePerformed.index,
        "startTime": workOrder.startTime,
        "endTime": workOrder.endTime,
        "description": workOrder.description,
        "concerne": workOrder.concerne,
        "sugestions": workOrder.sugestions,
        "appointmentId": workOrder.appointment!.id,
        "vehicleId": workOrder.vehicle!.id,
        "userId": workOrder.user?.id,
        "employeeId": workOrder.employee?.id,
        "servicePerformed": workOrder.servicePerformed.index,
        "garageBox": workOrder.garageBox.index
      };
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
                        child: Column(
                      children: [
                        _basicInfo(context),
                      ],
                    ))
                  ],
                )),
              ));
  }

  Widget _basicInfo(BuildContext context) {
    return Card(
        elevation: 2,
        child: Column(children: [
          Column(
            children: [
              Card(
                margin: const EdgeInsets.all(10),
                color: Theme.of(context).primaryColor,
                child: const SizedBox(
                  width: 800,
                  height: 30,
                  child: Text(
                    "Zatvaranje radnog naloga",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: Responsive.isDesktop(context)
                    ? (MediaQuery.of(context).size.width / 2.8)
                    : (MediaQuery.of(context).size.height / 1.5),
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
                        child: FormBuilderTextField(
                          enabled: false,
                          name: "orderNumber",
                          decoration:
                              const InputDecoration(labelText: "Broj naloga *"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FormBuilderDateTimePicker(
                          name: "startTime",
                          decoration: const InputDecoration(
                              labelText: "Pocetak termina *"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FormBuilderDateTimePicker(
                          name: "endTime",
                          decoration: const InputDecoration(
                              labelText: "Kraj termina *"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FormBuilderTextField(
                          name: "concerne",
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            labelText: "Obrati paznju *",
                          ),
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
                          name: "sugestions",
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          decoration: const InputDecoration(
                              labelText: "Prijedlog za servisera  *"),
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
                                    child: Text(
                                        "${type.firstName} ${type.lastName}"),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: SizedBox(
                        width: 300,
                        child: FormBuilderDropdown(
                          name: "servicePerformed",
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
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: SizedBox(
                        width: 300,
                        child: FormBuilderDropdown(
                          name: "garageBox",
                          decoration:
                              const InputDecoration(labelText: "Broj Garaze *"),
                          items: const [
                            DropdownMenuItem(
                              value: 0,
                              child: Text("Garaza 1"),
                            ),
                            DropdownMenuItem(
                              value: 1,
                              child: Text("Garaza 2"),
                            ),
                            DropdownMenuItem(
                              value: 2,
                              child: Text("Garaza 3"),
                            ),
                            DropdownMenuItem(
                              value: 3,
                              child: Text("Garaza 4"),
                            ),
                            DropdownMenuItem(
                              value: 4,
                              child: Text("Garaza 5"),
                            ),
                            DropdownMenuItem(
                              value: 5,
                              child: Text("Garaza 6"),
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
                          enabled: false,
                          name: "appointmentId",
                          decoration:
                              const InputDecoration(labelText: "Appointment *"),
                          items: _appointments.result
                              .map((type) => DropdownMenuItem(
                                    value: type.id,
                                    child: const Text("Appointment"),
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
                          decoration:
                              const InputDecoration(labelText: "Vozilo *"),
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
                      child: SizedBox(
                        width: 290,
                        child: FormBuilderDropdown(
                          enabled: false,
                          name: "userId",
                          decoration:
                              const InputDecoration(labelText: "Klijent *"),
                          items: _users.result
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
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FormBuilderTextField(
                          name: "total",
                          decoration:
                              const InputDecoration(labelText: "Cijena *"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        child: const Text("Dodaj dijelove"),
                        onPressed: () {
                          _openDialog(widget.id);
                        },
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(children: <Widget>[
                          ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: const WidgetStatePropertyAll(
                                  Size.fromHeight(45)),
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(Colors.green),
                              foregroundColor:
                                  WidgetStateProperty.all(Colors.white),
                            ),
                            child: const Text("SPREMI",
                                textAlign: TextAlign.center),
                            onPressed: () async {
                              var isValid =
                                  _formKey.currentState?.saveAndValidate();

                              if (isValid!) {
                                var request =
                                    Map.from(_formKey.currentState!.value);
                                _addParts();
                                if (widget.id != null) {
                                  await _workOrderProvider.update(
                                      widget.id!, request);
                                }

                                if (context.mounted) {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MasterScreen("Nalozi",
                                                  WorkOrderListScreen())));
                                }
                              }
                            },
                          ),
                          const SizedBox(height: 5),
                          ElevatedButton(
                            style: ButtonStyle(
                              minimumSize: const WidgetStatePropertyAll(
                                  Size.fromHeight(45)),
                              backgroundColor:
                                  WidgetStateProperty.all<Color>(Colors.red),
                              foregroundColor:
                                  WidgetStateProperty.all(Colors.white),
                            ),
                            child: const Text("OBRIŠI"),
                            onPressed: () async {
                              await _workOrderProvider.delete(widget.id!);
                              await _loadData(null);
                              setState(() {});
                              if (context.mounted) {
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ])),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }

  Widget _buildDialog(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
          child: SizedBox(
              width: 600,
              height: 600,
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                        decoration: const InputDecoration(
                          labelText: "Pretraga",
                          prefixIcon: Icon(Icons.search),
                        ),
                        onChanged: (String value) {
                          var partsSearch = PartSearch();
                          partsSearch.name = value;
                          searchParts(partsSearch);
                          setState(() {
                            return;
                          });
                        }),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  SizedBox(
                      height: 400,
                      width: 600,
                      child: ListView(
                        shrinkWrap: true,
                        children: partsList.keys.map((Part key) {
                          return CheckboxListTile(
                            title: Text(key.serialNumber),
                            autofocus: false,
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            value: partsList[key],
                            onChanged: (value) {
                              setState(() {
                                partsList[key] = value!;
                              });
                            },
                          );
                        }).toList(),
                      )),
                ],
              )));
    });
  }
}
