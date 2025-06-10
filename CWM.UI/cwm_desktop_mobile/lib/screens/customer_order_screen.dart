import 'package:cwm_desktop_mobile/models/paged_result.dart';
import 'package:cwm_desktop_mobile/models/requests/work_order_insert_update.dart';
import 'package:cwm_desktop_mobile/models/searches/part_work_order_search.dart';
import 'package:cwm_desktop_mobile/models/work_order.dart';
import 'package:cwm_desktop_mobile/providers/part_work_order_provider.dart';
import 'package:cwm_desktop_mobile/screens/customer_order_list_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/appointment.dart';
import '../models/employee.dart';
import '../models/user.dart';
import '../models/vehicle.dart';
import '../providers/appointment_provider.dart';
import '../providers/employee_provider.dart';
import '../providers/user_provider.dart';
import '../providers/vehicle_provider.dart';
import '../providers/work_order_provider.dart';
import '../widgets/responsive.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;

class CustomerOrderScreen extends StatefulWidget {
  final int? id;
  const CustomerOrderScreen(this.id, {super.key});

  @override
  State<CustomerOrderScreen> createState() => _CustomerOrderScreenState();
}

class _CustomerOrderScreenState extends State<CustomerOrderScreen> {
  late PartWorkOrderProvider _partWorkOrderProvider;
  late AppointmentProvider _appointmentProvider;
  late VehicleProvider _vehicleProvider;
  late UserProvider _userProvider;
  late EmployeeProvider _employeeProvider;
  late WorkOrderProvider _workOrderProvider;

  bool isLoading = true;
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  late WorkOrderInsertUpdate _updateWorkOrderValue;

  var _appointments = PagedResult<Appointment>();
  var _vehicles = PagedResult<Vehicle>();
  var _employees = PagedResult<Employee>();
  var _users = PagedResult<User>();
  late WorkOrder workOrder;
  double totalAmount = 0;

  @override
  void initState() {
    super.initState();

    _workOrderProvider = context.read<WorkOrderProvider>();
    _appointmentProvider = context.read<AppointmentProvider>();
    _partWorkOrderProvider = context.read<PartWorkOrderProvider>();
    _userProvider = context.read<UserProvider>();
    _employeeProvider = context.read<EmployeeProvider>();
    _vehicleProvider = context.read<VehicleProvider>();

    _loadData(widget.id);
  }

  Future _updateValue(int id, bool payment) async {
    if (id != null) {
      workOrder = await _workOrderProvider.get(id);
      workOrder.payment = payment;
      _updateWorkOrderValue = WorkOrderInsertUpdate(
          workOrder.orderNumber,
          workOrder.total,
          payment,
          workOrder.startTime,
          workOrder.endTime,
          workOrder.garageBox,
          workOrder.servicePerformed,
          workOrder.concerne,
          workOrder.description,
          workOrder.sugestions,
          workOrder.vehicle?.id.toString(),
          workOrder.user?.id.toString(),
          workOrder.appointment?.id.toString(),
          workOrder.employee?.id.toString());
    }
    return _updateWorkOrderValue.toJson();
  }

  Future _totalAmount(int? id) async {
    var partWorkOrderSearch = PartWorkOrderSearch();
    partWorkOrderSearch.includePart = true;
    partWorkOrderSearch.includeWorkOrder = true;
    partWorkOrderSearch.workOrderId = id;
    var partWorkOrder =
        await _partWorkOrderProvider.getAll(search: partWorkOrderSearch);
    var parts = partWorkOrder.result;
    for (var part in parts) {
      totalAmount += part.part!.price;
    }
    var totalWorkOrder = await _workOrderProvider.get(id!);
    totalAmount += totalWorkOrder.total;
  }

  Future _loadData(int? id) async {
    _totalAmount(id);
    _vehicles = await _vehicleProvider.getAll();
    _appointments = await _appointmentProvider.getAll();
    _users = await _userProvider.getAll();
    _employees = await _employeeProvider.getAll();

    if (id != null) {
      workOrder = await _workOrderProvider.get(id);

      _initialValue = {
        "orderNumber": workOrder.orderNumber,
        "description": workOrder.description,
        "startTime": workOrder.startTime,
        "endTime": workOrder.endTime,
        "appointmentId": workOrder.appointment?.id,
        "userId": workOrder.user?.id,
        "vehicleId": workOrder.vehicle?.id,
        "employeeId": workOrder.employee?.id,
        "servicePerformed": workOrder.servicePerformed.index,
        "garageBox": workOrder.garageBox.index,
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
    bool isCardValid = false;
    bool cardError = false;
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
                          enabled: false,
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
                          enabled: false,
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
                          enabled: false,
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
                          enabled: false,
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
                          enabled: false,
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
                          enabled: false,
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
                          enabled: false,
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
                          enabled: false,
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
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "UKUPNA SUMA: $totalAmount KM",
                          style: TextStyle(fontSize: 25),
                        )),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: FocusScope(
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            if (hasFocus) {
                              Scrollable.ensureVisible(
                                context,
                                duration: const Duration(milliseconds: 300),
                                alignment: 1.0, // Align to bottom
                              );
                            }
                          },
                          child: stripe.CardField(
                            onCardChanged: (card) {
                              setState(() {
                                isCardValid = card!.complete;
                                if (card.complete) {
                                  cardError = false;
                                }
                              });
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (!isCardValid && cardError) ...[
                      const SizedBox(height: 5.0),
                      Text(
                        "Please insert card details",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ],
                    ElevatedButton(
                      style: ButtonStyle(
                        minimumSize:
                            const WidgetStatePropertyAll(Size.fromHeight(40)),
                        backgroundColor:
                            WidgetStateProperty.all<Color>(Colors.red),
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                      ),
                      child: const Text("PLATI"),
                      onPressed: workOrder.payment
                          ? null
                          : () async {
                              var workOrderValue =
                                  await _updateValue(workOrder.id, true);
                              await _workOrderProvider.update(
                                  workOrder.id, workOrderValue);
                              await _workOrderProvider.insertReservation(
                                  workOrder, totalAmount);
                              await _loadData(null);
                              setState(() {});
                              if (context.mounted) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MasterScreen("Termini",
                                                CustomerOrderListScreen())));
                              }
                            },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }
}
