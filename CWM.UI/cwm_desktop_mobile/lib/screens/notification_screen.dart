import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/data_table_sources/notification_data_table_source.dart';
import 'package:cwm_desktop_mobile/models/enums/role.dart';
import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:cwm_desktop_mobile/providers/notification_provider.dart';
import 'package:cwm_desktop_mobile/providers/user_provider.dart';
import 'package:cwm_desktop_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../models/paged_result.dart';
import '../widgets/responsive.dart';
import '../widgets/search.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationProvider _notificationProvider;
  late UserProvider _userProvider;

  late NotificationDataTableSource notificationDataTableSource;

  final _formKey = GlobalKey<FormBuilderState>();
  var _users = PagedResult<User>();

  @override
  void initState() {
    super.initState();
    _notificationProvider = context.read<NotificationProvider>();
    _userProvider = context.read<UserProvider>();

    notificationDataTableSource =
        NotificationDataTableSource(_notificationProvider, _openDialog);

    _loadData(null);
  }

  Future _loadData(int? id) async {
    _users = await _userProvider.getAll();
    if (id != null) {
      var notification = await _notificationProvider.get(id);

      _formKey.currentState?.patchValue({
        "name": notification.name,
        "description": notification.description,
        "userId": notification.user?.id.toString() ?? "0",
      });
    } else {
      _formKey.currentState?.patchValue({
        "userId": Authorization.userId.toString(),
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
        Search("Dodaj obavijest", () => _openDialog(null),
            onSearch: (text) => notificationDataTableSource.filterData(text)),
        SizedBox(
          width: double.infinity,
          child: AdvancedPaginatedDataTable(
            showHorizontalScrollbarAlways: Responsive.isMobile(context),
            addEmptyRows: false,
            showCheckboxColumn: false,
            source: notificationDataTableSource,
            rowsPerPage: 7,
            columns: const [
              DataColumn(label: Text("Naziv")),
              DataColumn(label: Text("Ime")),
              DataColumn(label: Text("Prezime"))
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
            Text(id == null ? "Dodaj obavijest" : "Uredi obavijest"),
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
                      enabled: Authorization.roles.contains(Role.admin)
                          ? true
                          : false,
                      name: "name",
                      decoration: const InputDecoration(labelText: "Naziv *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Naziv je obavezan."),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderTextField(
                      enabled: Authorization.roles.contains(Role.admin)
                          ? true
                          : false,
                      name: "description",
                      decoration: const InputDecoration(labelText: "Opis *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Opis je obavezan."),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderDropdown(
                      enabled: false,
                      name: "userId",
                      decoration: const InputDecoration(labelText: "Kreator *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Kreator je obavezan."),
                      items: _users.result
                          .map((user) => DropdownMenuItem(
                                value: user.id.toString(),
                                child: Text(user.firstName),
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
          if (Authorization.roles.contains(Role.admin))
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
                  await _notificationProvider.delete(id);
                  notificationDataTableSource.filterData(null);
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
                                "* Ne možete obrisati ovu obavijest.",
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
        if (Authorization.roles.contains(Role.admin))
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
                    ? await _notificationProvider.insert(request)
                    : await _notificationProvider.update(id, request);

                notificationDataTableSource.filterData(null);
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
