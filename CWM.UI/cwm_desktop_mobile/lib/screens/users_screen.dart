import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/data_table_sources/user_data_table_source.dart';
import 'package:cwm_desktop_mobile/models/city.dart';
import 'package:cwm_desktop_mobile/models/country.dart';
import 'package:cwm_desktop_mobile/providers/city_provider.dart';
import 'package:cwm_desktop_mobile/providers/country_provider.dart';
import 'package:cwm_desktop_mobile/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../models/paged_result.dart';
import '../widgets/responsive.dart';
import '../widgets/search.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late UserProvider _userProvider;
  late CityProvider _cityProvider;
  late CountryProvider _countryProvider;

  late UserDataTableSource userDataTableSource;

  final _formKey = GlobalKey<FormBuilderState>();
  var _city = PagedResult<City>();
  var _country = PagedResult<Country>();

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _cityProvider = context.read<CityProvider>();
    _countryProvider = context.read<CountryProvider>();

    userDataTableSource = UserDataTableSource(_userProvider, _openDialog);

    _loadData(null);
  }

  Future _loadData(int? id) async {
    _city = await _cityProvider.getAll();
    _country = await _countryProvider.getAll();
    if (id != null) {
      var users = await _userProvider.get(id);

      _formKey.currentState?.patchValue({
        "firstName": users.firstName,
        "lastName": users.lastName,
        "username": users.username,
        "password": users.password,
        "birthDate": users.birthDate,
        "gender": users.gender.index,
        "cityId": users.city?.id,
        "countryId": users.citizenship?.id,
        "email": users.email,
        "mobile": users.mobile,
        "image": users.image ?? ""
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
        Search("Dodaj korisnika", () => _openDialog(null),
            onSearch: (text) => userDataTableSource.filterData(text)),
        SizedBox(
          width: double.infinity,
          child: AdvancedPaginatedDataTable(
            showHorizontalScrollbarAlways: Responsive.isMobile(context),
            addEmptyRows: false,
            showCheckboxColumn: false,
            source: userDataTableSource,
            rowsPerPage: 7,
            columns: const [
              DataColumn(label: Text("Ime")),
              DataColumn(label: Text("Prezime")),
              DataColumn(label: Text("Email"))
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
            Text(id == null ? "Dodaj korisnika" : "Uredi korisnika"),
          ],
        ),
      ),
      content: FormBuilder(
        key: _formKey,
        child: SizedBox(
          height: 500,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderTextField(
                      name: "firstName",
                      decoration: const InputDecoration(labelText: "Ime *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Ime je obavezno."),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderTextField(
                      name: "lastName",
                      decoration: const InputDecoration(labelText: "Prezime *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Prezime je obavezno."),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderTextField(
                      name: "password",
                      decoration: const InputDecoration(labelText: "Lozinka *"),
                      validator: FormBuilderValidators.password(
                          errorText: "Lozinka je obavezna."),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderTextField(
                      name: "email",
                      decoration: const InputDecoration(labelText: "Email *"),
                      validator: FormBuilderValidators.email(
                          errorText: "Email je obavezan."),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderTextField(
                      name: "mobile",
                      decoration: const InputDecoration(labelText: "Mobitel *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Mobitel je obavezan."),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 500,
                    child: FormBuilderDateTimePicker(
                      name: "birthDate",
                      decoration:
                          const InputDecoration(labelText: "Datum rodjenja *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Datum rodjenja je obavezan."),
                    ),
                  ),
                ],
              ),
              Row(children: [
                SizedBox(
                  width: 500,
                  child: FormBuilderDropdown(
                    name: "gender",
                    decoration: const InputDecoration(labelText: "Spol *"),
                    validator: FormBuilderValidators.required(
                        errorText: "Spol je obavezan."),
                    items: const [
                      DropdownMenuItem(
                        value: 0,
                        child: Text("Musko"),
                      ),
                      DropdownMenuItem(
                        value: 1,
                        child: Text("Zensko"),
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
                      name: "countryId",
                      decoration: const InputDecoration(labelText: "Drzava *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Drzava je obavezna."),
                      items: _country.result
                          .map((country) => DropdownMenuItem(
                                value: country.id,
                                child: Text(country.name),
                              ))
                          .toList(),
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
                      name: "cityId",
                      decoration: const InputDecoration(labelText: "Grad *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Grad je obavezan."),
                      items: _city.result
                          .map((city) => DropdownMenuItem(
                                value: city.id,
                                child: Text(city.name),
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
                await _userProvider.delete(id);
                userDataTableSource.filterData(null);
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
                              "* Ne možete obrisati ovaj utrosak.",
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
                  ? await _userProvider.insert(request)
                  : await _userProvider.update(id, request);

              userDataTableSource.filterData(null);
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
