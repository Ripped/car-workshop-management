import 'package:cwm_desktop_mobile/models/appointment.dart';
import 'package:cwm_desktop_mobile/models/appointment_type.dart';
import 'package:cwm_desktop_mobile/models/employee.dart';
import 'package:cwm_desktop_mobile/models/requests/appointment_insert_update.dart';
import 'package:cwm_desktop_mobile/models/searches/appointment_search.dart';
import 'package:cwm_desktop_mobile/models/searches/employee_search.dart';
import 'package:cwm_desktop_mobile/models/searches/user_search.dart';
import 'package:cwm_desktop_mobile/models/searches/vehicle_search.dart';
import 'package:cwm_desktop_mobile/models/searches/work_order_search.dart';
import 'package:cwm_desktop_mobile/providers/appointment_provider.dart';
import 'package:cwm_desktop_mobile/providers/employee_provider.dart';
import 'package:cwm_desktop_mobile/providers/vehicle_provider.dart';
import 'package:cwm_desktop_mobile/providers/work_order_provider.dart';
import 'package:cwm_desktop_mobile/screens/appointment_list_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/paged_result.dart';
import '../models/user.dart';
import '../models/vehicle.dart';
import '../providers/user_provider.dart';

class WorkOrderScreen extends StatefulWidget {
  final int? id;
  const WorkOrderScreen(this.id, {super.key});

  @override
  State<WorkOrderScreen> createState() => _WorkOrderScreen();
}

class _WorkOrderScreen extends State<WorkOrderScreen> {
  late AppointmentProvider _appointmentProvider;
  late WorkOrderProvider _workOrderProvider;
  late EmployeeProvider _employeeProvider;
  late UserProvider _userProvider;
  late VehicleProvider _vehicleProvider;
  late int? workOrderId;
  late AppointmentType? appointmentType;

  bool isLoading = true;
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  var _employees = PagedResult<Employee>();
  var _users = PagedResult<User>();
  var _appointments = PagedResult<Appointment>();
  var _vehicles = PagedResult<Vehicle>();
  @override
  void initState() {
    super.initState();

    workOrderId = null;
    _appointmentProvider = context.read<AppointmentProvider>();
    _workOrderProvider = context.read<WorkOrderProvider>();
    _employeeProvider = context.read<EmployeeProvider>();
    _userProvider = context.read<UserProvider>();
    _vehicleProvider = context.read<VehicleProvider>();

    _loadData(widget.id);
  }

  Future _loadData(int? id) async {
    var workOrderSearch = WorkOrderSearch();
    workOrderSearch.appointmentId = id;

    var employeeSearch = EmployeeSearch();
    employeeSearch.pageSize = 50;

    var appointmentSearch = AppointmentSearch();
    var userSearch = UserSearch();
    var vehicleSearch = VehicleSearch();

    _employees = await _employeeProvider.getAll(search: employeeSearch);

    var workOrder = await _workOrderProvider.getAll(search: workOrderSearch);
    if (workOrder.totalCount > 0) workOrderId = workOrder.result.first.id;

    if (id != null) {
      var appointment = await _appointmentProvider.get(id);
      _initialValue = {
        "orderNumber":
            "${appointment.vehicle!.chassis}-${appointment.startDate.month.toString()}${appointment.startDate.day.toString()}${appointment.startDate.year.toString()}",
        "description": appointment.description,
        "startTime": appointment.startDate,
        "endTime": appointment.endDate,
        "appointmentId": appointment.id,
        "userId": appointment.user?.id,
        "vehicleId": appointment.vehicle?.id,
        "employeeId": 1,
        "servicePerformed": 1,
        "garageBox": 1
      };
      vehicleSearch.name = appointment.vehicle!.chassis;
      userSearch.name = appointment.user!.firstName;
      appointmentSearch.appointmentId = appointment.id.toString();
      _users = await _userProvider.getAll(search: userSearch);
      _appointments =
          await _appointmentProvider.getAll(search: appointmentSearch);
      _vehicles = await _vehicleProvider.getAll(search: vehicleSearch);
    }
    setState(() {
      isLoading = false;
    });
  }

  appointmentApproval(int? id, int? appointmentType) async {
    if (id != null) {
      var appointment = await _appointmentProvider.get(id);

      var appointmentInsertUpdate = AppointmentInsertUpdate(
          appointment.description.toString(),
          appointment.startDate,
          appointment.endDate,
          appointment.user!.id.toString(),
          appointmentType.toString(),
          appointment.vehicle!.id.toString());

      return appointmentInsertUpdate.toJson();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                              child: const Text(
                                "Kreiranje radnog naloga",
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
                                    Padding(
                                      padding: const EdgeInsets.all(0),
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: FormBuilderTextField(
                                          enabled: false,
                                          name: "orderNumber",
                                          decoration: const InputDecoration(
                                              labelText: "Broj naloga *"),
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
                                          name: "sugestion",
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 3,
                                          decoration: const InputDecoration(
                                              labelText:
                                                  "Prijedlog za servisera  *"),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 0),
                                      child: SizedBox(
                                        width: 290,
                                        child: FormBuilderDropdown(
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 0),
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
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 0),
                                      child: SizedBox(
                                        width: 300,
                                        child: FormBuilderDropdown(
                                          name: "garageBox",
                                          decoration: const InputDecoration(
                                              labelText: "Broj Garaze *"),
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
                                          decoration: const InputDecoration(
                                              labelText: "Appointment *"),
                                          items: _appointments.result
                                              .map((type) => DropdownMenuItem(
                                                    value: type.id,
                                                    child: const Text(
                                                        "Appointment"),
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
                                      child: SizedBox(
                                        width: 290,
                                        child: FormBuilderDropdown(
                                          enabled: false,
                                          name: "userId",
                                          decoration: const InputDecoration(
                                              labelText: "Klijent *"),
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
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            minimumSize:
                                                const WidgetStatePropertyAll(
                                                    Size.fromHeight(50)),
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    Colors.green)),
                                        child: const Text(
                                          "POTVRDI TERMIN",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                        onPressed: () async {
                                          var isValid = _formKey.currentState
                                              ?.saveAndValidate();

                                          var newAppointment =
                                              await appointmentApproval(
                                                  widget.id!, 2);

                                          if (isValid!) {
                                            var request = Map.from(
                                                _formKey.currentState!.value);

                                            _appointmentProvider.update(
                                                widget.id!, newAppointment);

                                            workOrderId == null
                                                ? await _workOrderProvider
                                                    .insert(request)
                                                : await _workOrderProvider
                                                    .update(
                                                        workOrderId!, request);

                                            if (context.mounted) {
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MasterScreen(
                                                              "Termini",
                                                              AppointmentListScreen())));
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: ElevatedButton(
                                        style: const ButtonStyle(
                                            minimumSize: WidgetStatePropertyAll(
                                                Size.fromHeight(50))),
                                        child: const Text(
                                          "ODBIJ TERMIN",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20),
                                        ),
                                        onPressed: () async {
                                          var newAppointment =
                                              await appointmentApproval(
                                                  widget.id!, 3);
                                          if (widget.id != null) {
                                            await _appointmentProvider.update(
                                                widget.id!, newAppointment);

                                            if (context.mounted) {
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MasterScreen(
                                                              "Termini",
                                                              AppointmentListScreen())));
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            minimumSize:
                                                const WidgetStatePropertyAll(
                                                    Size.fromHeight(50)),
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    Colors.red)),
                                        child: const Text("OBRISI TERMIN",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20)),
                                        onPressed: () async {
                                          var newAppointment =
                                              await appointmentApproval(
                                                  widget.id!, 3);
                                          if (widget.id != null) {
                                            await _appointmentProvider.update(
                                                widget.id!, newAppointment);

                                            if (context.mounted) {
                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MasterScreen(
                                                              "Termini",
                                                              AppointmentListScreen())));
                                            }
                                          }
                                        },
                                      ),
                                    )
                                  ])),
                        ],
                      ),
                    ))
                  ],
                )),
              ));
  }
}
