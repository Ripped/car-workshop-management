import 'package:cwm_desktop_mobile/data_table_sources/appointment_data_table_source.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/enums/service.dart';
import '../models/paged_result.dart';
import '../models/appointment.dart' as appointment;
import '../models/appointment_type.dart' as appointment_type;
import '../models/appointment_blocked.dart' as appointment_blocked;

import 'package:provider/provider.dart';
import '../models/searches/appointment_search.dart';
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

  final _formKey = GlobalKey<FormBuilderState>();
  var _appointmentType = PagedResult<appointment_type.AppointmentType>();
  var _appointmentBlockedDates =
      PagedResult<appointment_blocked.AppointmentBlocked>();
  var _appointmentBlocked = <appointment_blocked.AppointmentBlocked>[];

  List<DateTime> blockedDates = <DateTime>[];

  @override
  void initState() {
    super.initState();

    _appointmentProvider = context.read<AppointmentProvider>();
    _appointmentTypeProvider = context.read<AppointmentTypeProvider>();
    _appointmentBlockedProvider = context.read<AppointmentBlockedProvider>();

    _loadData(null, null);
  }

  Future _loadData(int? id, DateTime? selectedDate) async {
    _appointmentType = await _appointmentTypeProvider.getAll();
    _appointmentBlockedDates = await _appointmentBlockedProvider.getAll();
    _appointmentBlocked = _appointmentBlockedDates.result.cast();

    for (appointment_blocked.AppointmentBlocked i in _appointmentBlocked) {
      blockedDates.add(i.blockedDate);
    }
    if (id != null) {
      var event = await _appointmentProvider.get(id);

      _formKey.currentState?.patchValue({
        "servicePerformed": event.servicePerformed,
        "description": event.description,
        "startDate": event.startDate,
        "endDate": event.endDate,
        "appointmentTypeId": event.appointmentType?.id.toString() ?? "0",
      });
    } else {
      _formKey.currentState?.patchValue({
        "startDate": selectedDate,
        "endDate": selectedDate,
      });
    }
  }

  void _openDialog(int? id, DateTime? selectedDate) {
    if (Responsive.isMobile(context)) return;

    _loadData(id, selectedDate).then((data) {
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            _buildDialog(context, id, selectedDate),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var eventSearch = AppointmentSearch();

    eventSearch.includeAppointmentType = true;
    eventSearch.pageSize = 50;

    _loadData(null, null);

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
            return FutureBuilder<PagedResult<appointment_type.AppointmentType>>(
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
                              view: CalendarView.month,
                              dataSource: AppointmentDataTableSource(
                                  snapshot.data!.result),
                              monthViewSettings: const MonthViewSettings(
                                  appointmentDisplayMode:
                                      MonthAppointmentDisplayMode.appointment,
                                  showAgenda: true),
                            ))
                      ]));
                    } else {
                      return SingleChildScrollView(
                          child: Column(children: [
                        SizedBox(
                            height: 500,
                            child: SfCalendar(
                              blackoutDates: blockedDates,
                              blackoutDatesTextStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.red),
                              view: CalendarView.month,
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
                                  agendaStyle: AgendaStyle(
                                    dayTextStyle: TextStyle(
                                        fontStyle: FontStyle.normal,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.green),
                                  )),
                            ))
                      ]));
                    }
                  }
                });
          }
        });
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
                Row(
                  children: [
                    SizedBox(
                      width: 600,
                      child: FormBuilderTextField(
                        name: "userId",
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
                        width: 600,
                        child: FormBuilderTextField(
                            name: "description",
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration:
                                const InputDecoration(labelText: "Opis"))),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                        width: 290,
                        child: FormBuilderDateTimePicker(
                          name: "startDate",
                          inputType: InputType.date,
                          format: DateFormat('dd.MM.yyyy.'),
                          decoration: const InputDecoration(
                              labelText: "Datum početka *"),
                        )),
                    const SizedBox(width: 20),
                    SizedBox(
                      width: 290,
                      child: FormBuilderDateTimePicker(
                        name: "endDate",
                        inputType: InputType.date,
                        format: DateFormat('dd.MM.yyyy.'),
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
                  foregroundColor: MaterialStateProperty.all(Colors.red),
                  padding: MaterialStateProperty.all(
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
                  padding: MaterialStateProperty.all(
                    const EdgeInsets.only(
                        left: 40, top: 20, right: 40, bottom: 20),
                  ),
                ),
                child: const Text("NAZAD"),
                onPressed: () => Navigator.pop(context),
              ),
              OutlinedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
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
}
