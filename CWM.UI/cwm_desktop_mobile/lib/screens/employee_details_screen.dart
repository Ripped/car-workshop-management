import 'dart:convert';
import 'dart:io';
import 'package:cwm_desktop_mobile/screens/employee_list_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
                        if (!Responsive.isMobile(context))
                          SizedBox(
                            //width: 300,
                            child: _partImage(context),
                          )
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
                "Pregled uposlenika",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            height: Responsive.isDesktop(context)
                ? (MediaQuery.of(context).size.width / 5)
                : 200,
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
                    name: "firstName",
                    decoration: const InputDecoration(labelText: "Ime *"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderTextField(
                    name: "lastName",
                    decoration: const InputDecoration(labelText: "Prezime *"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderDateTimePicker(
                    name: "birthDate",
                    decoration:
                        const InputDecoration(labelText: "Datum rodjenja *"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderDropdown(
                    name: "cityId",
                    decoration: const InputDecoration(labelText: "Grad"),
                    items: _cities.result
                        .map((city) => DropdownMenuItem(
                              value: city.id,
                              child: Text(city.name),
                            ))
                        .toList(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderDropdown(
                    name: "countryId",
                    decoration: const InputDecoration(labelText: "Drzava"),
                    items: _countries.result
                        .map((country) => DropdownMenuItem(
                              value: country.id,
                              child: Text(country.name),
                            ))
                        .toList(),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderTextField(
                    name: "email",
                    decoration: const InputDecoration(labelText: "Email *"),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderTextField(
                    name: "mobile",
                    decoration: const InputDecoration(labelText: "Mobitel *"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _partImage(BuildContext context) {
    return Card(
        elevation: 2,
        child: Row(children: <Widget>[
          Column(children: [
            Card(
              margin: const EdgeInsets.all(10),
              color: Theme.of(context).primaryColor,
              child: const SizedBox(
                width: 200,
                height: 30,
                child: Text(
                  "Slika uposlenika",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(150),
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(150),
                  child: Image.asset(
                    "assets/images/default-avatar.png",
                    width: 500,
                    height: 500,
                  ),
                ),
              ),
            ),
            Container(
              width: 500,
              padding: const EdgeInsets.all(20),
              child: FormBuilderField(
                name: 'image',
                builder: ((field) {
                  return InputDecorator(
                    decoration: InputDecoration(errorText: field.errorText),
                    child: ListTile(
                      leading: const Icon(Icons.photo),
                      title: const Text("Odaberite sliku"),
                      trailing: const Icon(Icons.file_upload),
                      onTap: _uploadImage,
                    ),
                  );
                }),
              ),
            ),
          ]),
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
                  child: const Text("SPREMI", textAlign: TextAlign.center),
                  onPressed: () async {
                    var isValid = _formKey.currentState?.saveAndValidate();

                    if (isValid!) {
                      var request = Map.from(_formKey.currentState!.value);

                      widget.id == null
                          ? await _employeeProvider.insert(request)
                          : await _employeeProvider.update(widget.id!, request);

                      if (context.mounted) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const MasterScreen(
                                "Uspolenici", EmployeeListScreen())));
                      }
                    }
                  },
                ),
              ])),
        ]));
  }
}
