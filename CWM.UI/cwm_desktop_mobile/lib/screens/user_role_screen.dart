import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/data_table_sources/user_role_data_table_source.dart';
import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:cwm_desktop_mobile/providers/user_provider.dart';
import 'package:cwm_desktop_mobile/providers/user_role_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/paged_result.dart';
import '../widgets/responsive.dart';
import '../widgets/search.dart';

class UserRoleScreen extends StatefulWidget {
  const UserRoleScreen({super.key});

  @override
  State<UserRoleScreen> createState() => _UserRoleScreenState();
}

class _UserRoleScreenState extends State<UserRoleScreen> {
  late UserRoleProvider _userRoleProvider;
  late UserProvider _userProvider;

  late UserRoleDataTableSource userRoleDataTableSource;

  final _formKey = GlobalKey<FormBuilderState>();
  var _users = PagedResult<User>();

  @override
  void initState() {
    super.initState();

    _userRoleProvider = context.read<UserRoleProvider>();
    _userProvider = context.read<UserProvider>();

    userRoleDataTableSource =
        UserRoleDataTableSource(_userRoleProvider, _openDialog);

    _loadData(null);
  }

  Future _loadData(int? id) async {
    _users = await _userProvider.getAll();

    if (id != null) {
      var userRole = await _userRoleProvider.get(id);

      _formKey.currentState?.patchValue({
        "role": userRole.role.name,
        "userId": userRole.user?.id.toString() ?? "0"
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
        Search("Dodaj ulogu", () => _openDialog(null),
            onSearch: (text) => userRoleDataTableSource.filterData(text)),
        SizedBox(
          width: double.infinity,
          child: AdvancedPaginatedDataTable(
            showHorizontalScrollbarAlways: Responsive.isMobile(context),
            addEmptyRows: false,
            showCheckboxColumn: false,
            source: userRoleDataTableSource,
            rowsPerPage: 7,
            columns: const [
              DataColumn(label: Text("Uloga")),
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
            Text(id == null ? "Dodaj ulogu" : "Uredi ulogu"),
          ],
        ),
      ),
      content: FormBuilder(
        key: _formKey,
        child: SizedBox(
          height: 300,
          child: Column(
            children: [
              Row(children: [
                SizedBox(
                  width: 500,
                  child: FormBuilderDropdown(
                    name: "role",
                    decoration: const InputDecoration(labelText: "Uloga *"),
                    items: const [
                      DropdownMenuItem(
                        value: 0,
                        child: Text("Admin"),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text("Employee"),
                      ),
                      DropdownMenuItem(
                        value: 2,
                        child: Text("User"),
                      ),
                    ],
                  ),
                ),
              ]),
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
                await _userRoleProvider.delete(id);
                userRoleDataTableSource.filterData(null);
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
                  ? await _userRoleProvider.insert(request)
                  : await _userRoleProvider.update(id, request);

              userRoleDataTableSource.filterData(null);
              if (context.mounted) Navigator.pop(context);
            }
          },
        ),
      ],
    );
  }
}
