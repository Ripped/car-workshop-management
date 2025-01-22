import 'package:cwm_desktop_mobile/models/appointment_type.dart';
import 'package:cwm_desktop_mobile/models/employee.dart';
import 'package:cwm_desktop_mobile/models/enums/garage_box.dart';
import 'package:cwm_desktop_mobile/models/enums/service.dart';
import 'package:cwm_desktop_mobile/models/requests/appointment_insert_update.dart';
import 'package:cwm_desktop_mobile/models/searches/employee_search.dart';
import 'package:cwm_desktop_mobile/models/searches/work_order_search.dart';
import 'package:cwm_desktop_mobile/providers/appointment_provider.dart';
import 'package:cwm_desktop_mobile/providers/employee_provider.dart';
import 'package:cwm_desktop_mobile/providers/work_order_provider.dart';
import 'package:cwm_desktop_mobile/screens/appointment_list_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/paged_result.dart';

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
  late int? workOrderId;
  late AppointmentType? appointmentType;

  bool isLoading = true;
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  var _employees = PagedResult<Employee>();

  @override
  void initState() {
    super.initState();

    workOrderId = null;
    _appointmentProvider = context.read<AppointmentProvider>();
    _workOrderProvider = context.read<WorkOrderProvider>();
    _employeeProvider = context.read<EmployeeProvider>();

    _loadData(widget.id);
  }

  Future _loadData(int? id) async {
    var workOrderSearch = WorkOrderSearch();
    workOrderSearch.appointmentId = id;

    var employeeSearch = EmployeeSearch();

    _employees = await _employeeProvider.getAll(search: employeeSearch);

    var workOrder = await _workOrderProvider.getAll(search: workOrderSearch);
    if (workOrder.totalCount > 0) workOrderId = workOrder.result.first.id;

    if (id != null) {
      var appointment = await _appointmentProvider.get(id);
      _initialValue = {
        "description": appointment.description,
        "startTime": appointment.startDate,
        "endTime": appointment.endDate,
        "appointmentId": appointment.id.toString(),
        "userId": appointment.user?.id.toString(),
        "vehicleId": appointment.vehicle?.id.toString(),
      };
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
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(10),
            color: Theme.of(context).primaryColor,
            child: const SizedBox(
              width: 800,
              height: 30,
              child: Text(
                "Kreiranje radnog naloga",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: Responsive.isDesktop(context)
                ? (MediaQuery.of(context).size.width / 5)
                : 300,
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
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderTextField(
                    name: "orderNumber",
                    decoration:
                        const InputDecoration(labelText: "Broj naloga *"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderTextField(
                    name: "userId",
                    decoration: const InputDecoration(labelText: "USER *"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderTextField(
                    name: "vehicleId",
                    decoration: const InputDecoration(labelText: "VEHICLE *"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderTextField(
                    name: "concerne",
                    decoration:
                        const InputDecoration(labelText: "Obrati paznju *"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderDateTimePicker(
                    name: "startTime",
                    decoration:
                        const InputDecoration(labelText: "Obrati paznju *"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderDateTimePicker(
                    name: "endTime",
                    decoration:
                        const InputDecoration(labelText: "Obrati paznju *"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderTextField(
                    name: "description",
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: const InputDecoration(
                        labelText: "Opis kvara vlasnika vozila  *"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderTextField(
                    name: "sugestion",
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: const InputDecoration(
                        labelText: "Prijedlog za servisera  *"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderTextField(
                    name: "appointmentId",
                    decoration:
                        const InputDecoration(labelText: "Appointment *"),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 290,
                      child: FormBuilderDropdown(
                        name: "servicePerformed",
                        decoration:
                            const InputDecoration(labelText: "Vrsta servisa *"),
                        items: Service.values
                            .map((type) => DropdownMenuItem(
                                  value: type.index,
                                  child: Text(type.name),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 290,
                      child: FormBuilderDropdown(
                        name: "garageBox",
                        decoration:
                            const InputDecoration(labelText: "Broj boxa *"),
                        items: GarageBox.values
                            .map((type) => DropdownMenuItem(
                                  value: type.index,
                                  child: Text(type.name),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
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
                    const SizedBox(width: 20),
                  ],
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
                                MaterialStatePropertyAll(Size.fromHeight(50))),
                        child: const Text("POTVRDI TERMIN",
                            textAlign: TextAlign.center),
                        onPressed: () async {
                          var isValid =
                              _formKey.currentState?.saveAndValidate();

                          var newAppointment =
                              await appointmentApproval(widget.id!, 2);

                          if (isValid!) {
                            var request =
                                Map.from(_formKey.currentState!.value);

                            _appointmentProvider.update(
                                widget.id!, newAppointment);

                            workOrderId == null
                                ? await _workOrderProvider.insert(request)
                                : await _workOrderProvider.update(
                                    workOrderId!, request);

                            if (context.mounted) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const MasterScreen(
                                          "Termini", AppointmentListScreen())));
                            }
                          }
                        },
                      ),
                      ElevatedButton(
                          style: const ButtonStyle(
                              minimumSize: MaterialStatePropertyAll(
                                  Size.fromHeight(50))),
                          child: const Text("ODBIJ TERMIN",
                              textAlign: TextAlign.center),
                          onPressed: () async {
                            var newAppointment =
                                await appointmentApproval(widget.id!, 3);
                            if (widget.id != null) {
                              await _appointmentProvider.update(
                                  widget.id!, newAppointment);

                              if (context.mounted) {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MasterScreen("Termini",
                                                AppointmentListScreen())));
                              }
                            }
                          }),
                    ])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
