import 'package:cwm_desktop_mobile/data_table_sources/appointment_data_table_source.dart';
import 'package:cwm_desktop_mobile/models/vehicle.dart';
import 'package:cwm_desktop_mobile/providers/vehicle_provider.dart';
import 'package:cwm_desktop_mobile/utils/utils.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../models/enums/role.dart';
import '../models/paged_result.dart';
import '../models/appointment.dart' as appointment;
import '../models/appointment_type.dart' as appointment_type;
import '../models/appointment_blocked.dart' as appointment_blocked;

import 'package:provider/provider.dart';
import '../models/searches/appointment_search.dart';
import '../models/searches/vehicle_search.dart';
import '../providers/appointment_blocked_provider.dart';
import '../providers/appointment_type_provider.dart';
import '../providers/appointment_provider.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late AppointmentProvider _appointmentProvider;
  late AppointmentTypeProvider _appointmentTypeProvider;
  late AppointmentBlockedProvider _appointmentBlockedProvider;
  late VehicleProvider _vehicleProvider;

  final _formKey = GlobalKey<FormBuilderState>();
  var _appointmentType = PagedResult<appointment_type.AppointmentType>();
  var _appointmentBlockedDates =
      PagedResult<appointment_blocked.AppointmentBlocked>();
  var _appointmentBlocked = <appointment_blocked.AppointmentBlocked>[];
  var _vehicle = PagedResult<Vehicle>();

  List<DateTime> blockedDates = <DateTime>[];
  DateTime startDate = DateTime.utc(2000, 12, 1);
  DateTime today = DateTime.now();
  DateTime endDate = DateTime.utc(2100, 12, 1);

  @override
  void initState() {
    super.initState();

    _appointmentProvider = context.read<AppointmentProvider>();
    _appointmentTypeProvider = context.read<AppointmentTypeProvider>();
    _appointmentBlockedProvider = context.read<AppointmentBlockedProvider>();
    _vehicleProvider = context.read<VehicleProvider>();

    _loadData(null, null);
  }

  Future _loadData(int? id, DateTime? selectedDate) async {
    var vehicleSearch = VehicleSearch();
    vehicleSearch.pageSize = 50;
    vehicleSearch.userId = Authorization.userId;

    _appointmentBlockedDates = await _appointmentBlockedProvider.getAll();
    _appointmentBlocked = _appointmentBlockedDates.result.cast();
    _appointmentType = await _appointmentTypeProvider.getAll();
    _vehicle = await _vehicleProvider.getAll(search: vehicleSearch);

    _blockDates();
    for (appointment_blocked.AppointmentBlocked i in _appointmentBlocked) {
      blockedDates.add(i.blockedDate);
    }
    if (id != null) {
      var event = await _appointmentProvider.get(id);

      _formKey.currentState?.patchValue({
        "userId": Authorization.userId.toString(),
        "description": event.description,
        "startDate": event.startDate,
        "endDate": event.endDate,
        "appointmentTypeId": event.appointmentType?.id.toString() ?? "0",
        "vehicleId": event.vehicle?.id.toString() ?? "0"
      });
    } else {
      _formKey.currentState?.patchValue({
        "startDate": selectedDate,
        "endDate": selectedDate,
        "userId": Authorization.userId.toString(),
        "appointmentTypeId": "1",
      });
    }
  }

  void _openDialog(int? id, DateTime? selectedDate) {
    if (Responsive.isMobile(context)) {
      _loadData(id, selectedDate).then((data) {
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              _datesBuildDialogMobile(context, id, selectedDate),
        );
      });
    } else {
      _loadData(id, selectedDate).then((data) {
        showDialog(
          context: context,
          builder: (BuildContext context) =>
              _buildDialog(context, id, selectedDate),
        );
      });
    }
  }

  _blockDates() {
    DateTime date;
    for (date = startDate;
        date.isBefore(endDate) || date == endDate;
        date = date.add(const Duration(days: 1))) {
      if (date.weekday != DateTime.sunday &&
          date.weekday != DateTime.saturday) {
        continue;
      }

      blockedDates.add(date);
    }
    final yesterday = today.subtract(const Duration(days: 1));
    for (date = startDate;
        date.isBefore(yesterday) || date == yesterday;
        date = date.add(const Duration(days: 1))) {
      blockedDates.add(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    var eventSearch = AppointmentSearch();

    eventSearch.includeAppointmentType = true;
    eventSearch.pageSize = 50;
    if (Authorization.roles.contains(Role.employee) ||
        Authorization.roles.contains(Role.user)) {
      eventSearch.userId = Authorization.userId;
    }

    _loadData(null, null);

    return FutureBuilder<PagedResult<appointment_blocked.AppointmentBlocked>>(
      future: _appointmentBlockedProvider.getAll(),
      builder: (context, snapshotBlockedDates) {
        if (snapshotBlockedDates.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshotBlockedDates.hasError) {
          return Text("Error: ${snapshotBlockedDates.error}");
        } else if (!snapshotBlockedDates.hasData ||
            snapshotBlockedDates.data?.result == null) {
          return const Text("Podaci nisu dostupni.");
        } else {
          return FutureBuilder<PagedResult<appointment.Appointment>>(
            future: _appointmentProvider.getAll(search: eventSearch),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else if (!snapshot.hasData || snapshot.data?.result == null) {
                return const Text("Podaci nisu dostupni.");
              } else {
                return FutureBuilder<
                    PagedResult<appointment_type.AppointmentType>>(
                  future: _appointmentTypeProvider.getAll(),
                  builder: (context, snapshotEventTypes) {
                    if (snapshotEventTypes.connectionState ==
                        ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshotEventTypes.hasError) {
                      return Text("Error: ${snapshotEventTypes.error}");
                    } else if (!snapshotEventTypes.hasData ||
                        snapshotEventTypes.data?.result == null) {
                      return const Text("Podaci nisu dostupni");
                    } else {
                      if (Responsive.isMobile(context)) {
                        return SingleChildScrollView(
                            child: Column(children: [
                          SizedBox(
                              width: 900,
                              height: 500,
                              child: SfCalendar(
                                blackoutDates: blockedDates,
                                blackoutDatesTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.red),
                                view: CalendarView.month,
                                firstDayOfWeek: 1,
                                onTap: (CalendarTapDetails details) {
                                  if (details.targetElement ==
                                      CalendarElement.calendarCell) {
                                    var selectedDate = details.date!;
                                    _openDialog(null, selectedDate);
                                  }
                                  if (details.targetElement ==
                                      CalendarElement.appointment) {
                                    int id = details.appointments?[0].id;
                                    _openDialog(id, null);
                                  }
                                },
                                dataSource: AppointmentDataTableSource(
                                    snapshot.data!.result),
                                monthViewSettings: const MonthViewSettings(
                                    showTrailingAndLeadingDates: false,
                                    monthCellStyle: MonthCellStyle(
                                      textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.green,
                                      ),
                                    ),
                                    appointmentDisplayMode:
                                        MonthAppointmentDisplayMode.appointment,
                                    showAgenda: true,
                                    dayFormat: 'EEE',
                                    agendaStyle: AgendaStyle(
                                      dayTextStyle: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.green),
                                    )),
                              ))
                        ]));
                      } else {
                        return Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: SizedBox(
                                  height: 800,
                                  child: SfCalendar(
                                    blackoutDates: blockedDates,
                                    blackoutDatesTextStyle: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.red),
                                    view: CalendarView.month,
                                    firstDayOfWeek: 1,
                                    onTap: (CalendarTapDetails details) {
                                      if (details.targetElement ==
                                          CalendarElement.calendarCell) {
                                        var selectedDate = details.date!;
                                        _openDialog(null, selectedDate);
                                      }
                                      if (details.targetElement ==
                                          CalendarElement.appointment) {
                                        int id = details.appointments?[0].id;
                                        _openDialog(id, null);
                                      }
                                    },
                                    dataSource: AppointmentDataTableSource(
                                        snapshot.data!.result),
                                    monthViewSettings: const MonthViewSettings(
                                        showTrailingAndLeadingDates: false,
                                        monthCellStyle: MonthCellStyle(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.green,
                                          ),
                                        ),
                                        appointmentDisplayMode:
                                            MonthAppointmentDisplayMode
                                                .appointment,
                                        showAgenda: true,
                                        dayFormat: 'EEE',
                                        agendaStyle: AgendaStyle(
                                          dayTextStyle: TextStyle(
                                              fontStyle: FontStyle.normal,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.green),
                                        )),
                                  )),
                            ),
                          ],
                        );
                      }
                    }
                  },
                );
              }
            },
          );
        }
      },
    );
  }

  Widget _buildDialog(BuildContext context, int? id, DateTime? selectedDate) {
    _loadData(id, selectedDate);

    return AlertDialog(
        title: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(id == null ? Icons.add : Icons.edit),
              const SizedBox(width: 10),
              Text(id == null ? "Dodaj termin" : "Uredi termin"),
            ],
          ),
        ),
        content: FormBuilder(
          key: _formKey,
          child: SizedBox(
            height: 450,
            child: Column(
              children: [
                SizedBox(
                  width: 600,
                  child: FormBuilderTextField(
                    name: "userId",
                    enabled: false,
                    decoration: const InputDecoration(labelText: "Korisnik *"),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                    width: 600,
                    child: FormBuilderTextField(
                        name: "description",
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: const InputDecoration(labelText: "Opis"))),
                const SizedBox(width: 20),
                Row(
                  children: [
                    SizedBox(
                        width: 290,
                        child: FormBuilderDateTimePicker(
                          enabled: false,
                          name: "startDate",
                          inputType: InputType.date,
                          format: DateFormat('dd.MM.yyyy'),
                          decoration: const InputDecoration(
                              labelText: "Datum početka *"),
                        )),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 290,
                      child: FormBuilderDateTimePicker(
                        enabled: false,
                        name: "endDate",
                        inputType: InputType.date,
                        format: DateFormat('dd.MM.yyyy'),
                        decoration:
                            const InputDecoration(labelText: "Datum kraja *"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: 290,
                      child: FormBuilderDropdown(
                        name: "appointmentTypeId",
                        decoration: const InputDecoration(labelText: "Vrsta *"),
                        enabled: false,
                        items: _appointmentType.result
                            .map((type) => DropdownMenuItem(
                                  value: type.id.toString(),
                                  child: Text(type.name),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: 290,
                      child: FormBuilderDropdown(
                        name: "vehicleId",
                        decoration: const InputDecoration(
                            labelText: "Odaberi automobil *"),
                        items: _vehicle.result
                            .map((type) => DropdownMenuItem(
                                  value: type.id.toString(),
                                  child: Text(type.chassis),
                                ))
                            .toList(),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ],
            ),
          ),
        ),
        actionsPadding: const EdgeInsets.all(20),
        buttonPadding: const EdgeInsets.all(20),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(Colors.red),
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.only(
                        left: 40, top: 20, right: 40, bottom: 20),
                  ),
                ),
                child: const Text("OBRIŠI"),
                onPressed: () async {
                  await _appointmentProvider.delete(id!);
                  await _loadData(null, null);
                  setState(() {});
                  if (context.mounted) Navigator.pop(context);
                },
              ),
              OutlinedButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.only(
                        left: 40, top: 20, right: 40, bottom: 20),
                  ),
                ),
                child: const Text("NAZAD"),
                onPressed: () => Navigator.pop(context),
              ),
              OutlinedButton(
                style: ButtonStyle(
                  padding: WidgetStateProperty.all(
                    const EdgeInsets.only(
                        left: 40, top: 20, right: 40, bottom: 20),
                  ),
                ),
                child: const Text("SPREMI"),
                onPressed: () async {
                  var isValid = _formKey.currentState?.saveAndValidate();

                  if (isValid!) {
                    var request = Map.from(_formKey.currentState!.value);

                    id == null
                        ? await _appointmentProvider.insert(request)
                        : await _appointmentProvider.update(id, request);

                    await _loadData(null, null);
                    setState(() {});
                    if (context.mounted) Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ]);
  }

  Widget _datesBuildDialogMobile(
      BuildContext context, int? id, DateTime? selectedDate) {
    _loadData(id, selectedDate);

    return AlertDialog(
      title: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(id == null ? Icons.add : Icons.edit),
            const SizedBox(width: 10),
            Text(id == null ? "Dodaj termin" : "Uredi termin"),
          ],
        ),
      ),
      content: SizedBox(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FormBuilderTextField(
                      name: "userId",
                      enabled: false,
                      decoration:
                          const InputDecoration(labelText: "Korisnik *"),
                    ),
                  ),
                  const SizedBox(width: 20),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FormBuilderTextField(
                          name: "description",
                          keyboardType: TextInputType.multiline,
                          validator: FormBuilderValidators.required(
                              errorText: "Opis je obavezan."),
                          maxLines: 4,
                          decoration:
                              const InputDecoration(labelText: "Opis"))),
                  const SizedBox(width: 20),
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: FormBuilderDateTimePicker(
                        enabled: false,
                        name: "startDate",
                        inputType: InputType.date,
                        format: DateFormat('dd.MM.yyyy'),
                        decoration:
                            const InputDecoration(labelText: "Datum početka *"),
                      )),
                  const SizedBox(width: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: FormBuilderDateTimePicker(
                      enabled: false,
                      name: "endDate",
                      inputType: InputType.date,
                      format: DateFormat('dd.MM.yyyy'),
                      decoration:
                          const InputDecoration(labelText: "Datum kraja *"),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: FormBuilderDropdown(
                      name: "appointmentTypeId",
                      decoration: const InputDecoration(labelText: "Vrsta *"),
                      enabled: false,
                      items: _appointmentType.result
                          .map((type) => DropdownMenuItem(
                                value: type.id.toString(),
                                child: Text(type.name),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 300,
                    child: FormBuilderDropdown(
                      alignment: Alignment.center,
                      name: "vehicleId",
                      decoration: const InputDecoration(
                          labelText: "Odaberi automobil *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Automobil je obavezan."),
                      items: _vehicle.result
                          .map((type) => DropdownMenuItem(
                                value: type.id.toString(),
                                child: Text(type.chassis),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          minimumSize:
                              WidgetStatePropertyAll(Size.fromHeight(50))),
                      child: const Text(
                        "NAZAD",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          minimumSize:
                              const WidgetStatePropertyAll(Size.fromHeight(50)),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.red)),
                      child: const Text(
                        "OBRIŠI",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onPressed: () async {
                        await _appointmentProvider.delete(id!);
                        await _loadData(null, null);
                        setState(() {});
                        if (context.mounted) Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          minimumSize:
                              const WidgetStatePropertyAll(Size.fromHeight(50)),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.green)),
                      child: const Text(
                        "SPREMI",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onPressed: () async {
                        var isValid = _formKey.currentState?.saveAndValidate();

                        if (isValid!) {
                          var request = Map.from(_formKey.currentState!.value);

                          id == null
                              ? await _appointmentProvider.insert(request)
                              : await _appointmentProvider.update(id, request);

                          await _loadData(null, null);
                          setState(() {});
                          if (context.mounted) Navigator.pop(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
