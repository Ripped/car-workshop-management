import 'dart:convert';
import 'dart:io';
import 'package:cwm_desktop_mobile/screens/employee_list_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../models/city.dart';
import '../models/country.dart';
import '../models/paged_result.dart';
import '../providers/city_provider.dart';
import '../providers/country_provider.dart';
import '../providers/employee_provider.dart';
import '../widgets/master_screen.dart';
import '../widgets/responsive.dart';

class EmployeeDetailsScreen extends StatefulWidget {
  final int? id;
  const EmployeeDetailsScreen(this.id, {super.key});

  @override
  State<EmployeeDetailsScreen> createState() => _EmployeeDetailsScreenState();
}

class _EmployeeDetailsScreenState extends State<EmployeeDetailsScreen> {
  late EmployeeProvider _employeeProvider;
  late CityProvider _cityProvider;
  late CountryProvider _countryProvider;

  bool isLoading = true;
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  var _cities = PagedResult<City>();
  var _countries = PagedResult<Country>();

  @override
  void initState() {
    super.initState();

    _employeeProvider = context.read<EmployeeProvider>();
    _cityProvider = context.read<CityProvider>();
    _countryProvider = context.read<CountryProvider>();

    _loadData(widget.id);
  }

  Future _loadData(int? id) async {
    _cities = await _cityProvider.getAll();
    _countries = await _countryProvider.getAll();

    if (id != null) {
      var employee = await _employeeProvider.get(id);

      _initialValue = {
        "firstName": employee.firstName,
        "lastName": employee.lastName,
        "birthDate": employee.birthDate,
        "cityId": employee.city?.id,
        "countryId": employee.citizenship?.id,
        "email": employee.email,
        "mobile": employee.mobile,
        "image": employee.image ?? ""
      };
    } else {
      _initialValue = {"image": "", "description": ""};
    }
    setState(() {
      isLoading = false;
    });
  }

  Future _uploadImage() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.single.path != null) {
      var image = File(result.files.single.path!);
      _initialValue["image"] = base64Encode(image.readAsBytesSync());
      _formKey.currentState!.fields["image"]!.didChange(_initialValue["image"]);
      setState(() {});
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
                            child: Column(children: [
                              Card(
                                margin: const EdgeInsets.all(10),
                                color: Theme.of(context).primaryColor,
                                child: const SizedBox(
                                  width: 800,
                                  height: 30,
                                  child: Text(
                                    "Pregled uposlenika",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                              if (Responsive.isDesktop(context))
                                SizedBox(
                                    child: Column(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(150),
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(150),
                                        child: _initialValue["image"] != ""
                                            ? Image.memory(
                                                base64Decode(
                                                    _initialValue["image"]),
                                                width: 250,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                "assets/images/default-avatar.png",
                                                width: 250,
                                                height: 250,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Card(
                                    margin: const EdgeInsets.all(10),
                                    color: Theme.of(context).primaryColor,
                                    child: const SizedBox(
                                      width: 200,
                                      height: 30,
                                      child: Text(
                                        "Slika uposlenika",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ])),
                              SizedBox(
                                height: Responsive.isDesktop(context)
                                    ? (MediaQuery.of(context).size.width / 4.5)
                                    : (MediaQuery.of(context).size.height /
                                        1.4),
                                child: GridView.count(
                                    scrollDirection: Axis.vertical,
                                    crossAxisCount:
                                        Responsive.isDesktop(context)
                                            ? 3
                                            : Responsive.isTablet(context)
                                                ? 2
                                                : 1,
                                    childAspectRatio: 4,
                                    crossAxisSpacing: 20,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: FormBuilderTextField(
                                            name: "firstName",
                                            decoration: const InputDecoration(
                                                labelText: "Ime *"),
                                            validator:
                                                FormBuilderValidators.required(
                                                    errorText:
                                                        "Ime je obavezno."),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: FormBuilderDateTimePicker(
                                            name: "birthDate",
                                            decoration: const InputDecoration(
                                                labelText: "Datum rodjenja *"),
                                            validator:
                                                FormBuilderValidators.required(
                                                    errorText:
                                                        "Datum je obavezan."),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: FormBuilderTextField(
                                            name: "lastName",
                                            decoration: const InputDecoration(
                                                labelText: "Prezime *"),
                                            validator:
                                                FormBuilderValidators.required(
                                                    errorText:
                                                        "Prezime je obavezno."),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: FormBuilderDropdown(
                                            name: "cityId",
                                            decoration: const InputDecoration(
                                                labelText: "Grad"),
                                            validator:
                                                FormBuilderValidators.required(
                                                    errorText:
                                                        "Grad je obavezan."),
                                            items: _cities.result
                                                .map((city) => DropdownMenuItem(
                                                      value: city.id,
                                                      child: Text(city.name),
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: FormBuilderDropdown(
                                            name: "countryId",
                                            decoration: const InputDecoration(
                                                labelText: "Drzava"),
                                            validator:
                                                FormBuilderValidators.required(
                                                    errorText:
                                                        "Drzava je obavezna."),
                                            items: _countries.result
                                                .map((country) =>
                                                    DropdownMenuItem(
                                                      value: country.id,
                                                      child: Text(country.name),
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: FormBuilderTextField(
                                            name: "email",
                                            decoration: const InputDecoration(
                                                labelText: "Email *"),
                                            validator:
                                                FormBuilderValidators.required(
                                                    errorText:
                                                        "Email je obavezan."),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: FormBuilderTextField(
                                            name: "mobile",
                                            decoration: const InputDecoration(
                                                labelText: "Mobitel *"),
                                            validator:
                                                FormBuilderValidators.required(
                                                    errorText:
                                                        "Mobitel je obavezan."),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: FormBuilderField(
                                            name: 'image',
                                            builder: ((field) {
                                              return InputDecorator(
                                                decoration: InputDecoration(
                                                    errorText: field.errorText),
                                                child: ListTile(
                                                  leading:
                                                      const Icon(Icons.photo),
                                                  title: const Text(
                                                      "Odaberite sliku"),
                                                  trailing: const Icon(
                                                      Icons.file_upload),
                                                  onTap: _uploadImage,
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                      ),
                                      if (Responsive.isDesktop(context) ||
                                          Responsive.isTablet(context))
                                        Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Column(children: <Widget>[
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  minimumSize:
                                                      const WidgetStatePropertyAll(
                                                          Size.fromHeight(50)),
                                                  backgroundColor:
                                                      WidgetStateProperty.all<
                                                          Color>(Colors.green),
                                                  foregroundColor:
                                                      WidgetStateProperty.all(
                                                          Colors.white),
                                                ),
                                                child: const Text("SPREMI",
                                                    textAlign:
                                                        TextAlign.center),
                                                onPressed: () async {
                                                  var isValid = _formKey
                                                      .currentState
                                                      ?.saveAndValidate();

                                                  if (isValid!) {
                                                    var request = Map.from(
                                                        _formKey.currentState!
                                                            .value);

                                                    widget.id == null
                                                        ? await _employeeProvider
                                                            .insert(request)
                                                        : await _employeeProvider
                                                            .update(widget.id!,
                                                                request);

                                                    if (context.mounted) {
                                                      Navigator.of(context).pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const MasterScreen(
                                                                      "Uspolenici",
                                                                      EmployeeListScreen())));
                                                    }
                                                  }
                                                },
                                              ),
                                              const SizedBox(height: 10),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                  minimumSize:
                                                      const WidgetStatePropertyAll(
                                                          Size.fromHeight(50)),
                                                  backgroundColor:
                                                      WidgetStateProperty.all<
                                                          Color>(Colors.red),
                                                  foregroundColor:
                                                      WidgetStateProperty.all(
                                                          Colors.white),
                                                ),
                                                child: const Text("OBRIŠI"),
                                                onPressed: () async {
                                                  await _employeeProvider
                                                      .delete(widget.id!);
                                                  await _loadData(null);
                                                  setState(() {});
                                                  if (context.mounted) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),
                                            ])),
                                      if (Responsive.isMobile(context))
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                40, 0, 0, 20),
                                            child: Row(children: <Widget>[
                                              SizedBox(
                                                width: 150,
                                                height: 90,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    minimumSize:
                                                        const WidgetStatePropertyAll(
                                                            Size.fromHeight(
                                                                50)),
                                                    backgroundColor:
                                                        WidgetStateProperty.all<
                                                                Color>(
                                                            Colors.green),
                                                    foregroundColor:
                                                        WidgetStateProperty.all(
                                                            Colors.white),
                                                  ),
                                                  child: const Text("SPREMI",
                                                      textAlign:
                                                          TextAlign.center),
                                                  onPressed: () async {
                                                    var isValid = _formKey
                                                        .currentState
                                                        ?.saveAndValidate();

                                                    if (isValid!) {
                                                      var request = Map.from(
                                                          _formKey.currentState!
                                                              .value);

                                                      widget.id == null
                                                          ? await _employeeProvider
                                                              .insert(request)
                                                          : await _employeeProvider
                                                              .update(
                                                                  widget.id!,
                                                                  request);

                                                      if (context.mounted) {
                                                        Navigator.of(context).pushReplacement(
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    const MasterScreen(
                                                                        "Uspolenici",
                                                                        EmployeeListScreen())));
                                                      }
                                                    }
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              SizedBox(
                                                width: 150,
                                                height: 90,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    minimumSize:
                                                        const WidgetStatePropertyAll(
                                                            Size.fromHeight(
                                                                40)),
                                                    backgroundColor:
                                                        WidgetStateProperty.all<
                                                            Color>(Colors.red),
                                                    foregroundColor:
                                                        WidgetStateProperty.all(
                                                            Colors.white),
                                                  ),
                                                  child: const Text("OBRIŠI"),
                                                  onPressed: () async {
                                                    await _employeeProvider
                                                        .delete(widget.id!);
                                                    await _loadData(null);
                                                    setState(() {});
                                                    if (context.mounted) {
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                ),
                                              )
                                            ])),
                                    ]),
                              ),
                            ])))
                  ],
                ),
              )),
    );
  }
}
