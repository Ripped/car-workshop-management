import 'dart:convert';
import 'dart:io';

import 'package:cwm_desktop_mobile/models/city.dart';
import 'package:cwm_desktop_mobile/models/country.dart';
import 'package:cwm_desktop_mobile/models/paged_result.dart';
import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:cwm_desktop_mobile/providers/city_provider.dart';
import 'package:cwm_desktop_mobile/providers/country_provider.dart';
import 'package:cwm_desktop_mobile/providers/user_provider.dart';
import 'package:cwm_desktop_mobile/utils/utils.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserProvider _userProvider;
  late CityProvider _cityProvider;
  late CountryProvider _countryProvider;
  late User userResult;
  bool isLoading = true;

  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  var _cities = PagedResult<City>();
  var _countries = PagedResult<Country>();

  @override
  void initState() {
    super.initState();
    _userProvider = context.read<UserProvider>();
    _cityProvider = context.read<CityProvider>();
    _countryProvider = context.read<CountryProvider>();

    _loadData();
  }

  Future _loadData() async {
    _cities = await _cityProvider.getAll();
    _countries = await _countryProvider.getAll();

    userResult = await _userProvider.get(Authorization.userId!);

    if (Authorization.userId != null) {
      var userResult = await _userProvider.get(Authorization.userId!);

      _initialValue = {
        "firstName": userResult.firstName,
        "lastName": userResult.lastName,
        "username": userResult.username,
        "password": userResult.password,
        "birthDate": userResult.birthDate,
        "gender": userResult.gender.index,
        "cityId": userResult.city?.id,
        "countryId": userResult.citizenship?.id,
        "email": userResult.email,
        "mobile": userResult.mobile,
        "image": userResult.image ?? ""
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
                                    "Pregled profila",
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
                                        "Slika korisnika",
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
                                          child: FormBuilderTextField(
                                              name: "username",
                                              decoration: const InputDecoration(
                                                  labelText: "Username *"),
                                              validator: FormBuilderValidators
                                                  .username(
                                                      errorText:
                                                          "Username je obavezno.")),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: FormBuilderTextField(
                                            name: "password",
                                            decoration: const InputDecoration(
                                                labelText: "Lozinka *"),
                                            validator:
                                                FormBuilderValidators.password(
                                                    errorText:
                                                        "Lozinka je obavezna."),
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
                                                        "Datum rodjenja je obavezan."),
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
                                            name: "gender",
                                            decoration: const InputDecoration(
                                                labelText: "Spol *"),
                                            validator:
                                                FormBuilderValidators.required(
                                                    errorText:
                                                        "Spol je obavezan."),
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
                                                FormBuilderValidators.email(
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
                                        padding: const EdgeInsets.all(10),
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

                                                    Authorization.userId == null
                                                        ? await _userProvider
                                                            .insert(request)
                                                        : await _userProvider
                                                            .update(
                                                                Authorization
                                                                    .userId!,
                                                                request);

                                                    if (context.mounted) {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          backgroundColor:
                                                              Colors.green[800],
                                                          showCloseIcon: false,
                                                          duration: Durations
                                                              .extralong4,
                                                          content: const Text(
                                                              "Podaci su spremljeni"),
                                                        ),
                                                      );
                                                      Navigator.of(context).pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const MasterScreen(
                                                                      "Profil",
                                                                      ProfileScreen())));
                                                    }
                                                  }
                                                },
                                              ),
                                            ])),
                                      if (Responsive.isMobile(context))
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            minimumSize:
                                                const WidgetStatePropertyAll(
                                                    Size.fromHeight(40)),
                                            backgroundColor:
                                                WidgetStateProperty.all<Color>(
                                                    Colors.green),
                                            foregroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.white),
                                          ),
                                          onPressed: () async {
                                            var isValid = _formKey.currentState
                                                ?.saveAndValidate();

                                            if (isValid!) {
                                              var request = Map.from(
                                                  _formKey.currentState!.value);

                                              Authorization.userId == null
                                                  ? await _userProvider
                                                      .insert(request)
                                                  : await _userProvider.update(
                                                      Authorization.userId!,
                                                      request);

                                              if (context.mounted) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    backgroundColor:
                                                        Colors.green[800],
                                                    showCloseIcon: false,
                                                    duration:
                                                        Durations.extralong4,
                                                    content: const Text(
                                                        "Podaci su spremljeni"),
                                                  ),
                                                );
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MasterScreen(
                                                                "Profil",
                                                                ProfileScreen())));
                                              }
                                            }
                                          },
                                          child: const Text("SPREMI"),
                                        ),
                                    ]),
                              ),
                            ])))
                  ],
                ),
              )),
    );
  }
}
