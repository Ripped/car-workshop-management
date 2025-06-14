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
//import 'package:image_picker/image_picker.dart';
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
                                          ),
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
                                              /*const SizedBox(height: 10),
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
                                                  await _userProvider
                                                      .delete(widget.id!);
                                                  await _loadData(null);
                                                  setState(() {});
                                                  if (context.mounted) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                              ),*/
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

                                                      Authorization.userId ==
                                                              null
                                                          ? await _userProvider
                                                              .insert(request)
                                                          : await _userProvider
                                                              .update(
                                                                  Authorization
                                                                      .userId!,
                                                                  request);

                                                      if (context.mounted) {
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
                                              ),
                                              /*const SizedBox(width: 10),
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
                                              )*/
                                            ])),
                                    ]),
                              ),
                            ])))
                  ],
                ),
              )),
    );
  }

  /*@override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            _buildProfilImage(context),
            const SizedBox(height: 18.0),
            Center(
              child: Text(
                '${korisnikResult.ime} ${korisnikResult.prezime}',
                style: const TextStyle(
                    fontSize: 19.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87),
              ),
            ),
            Divider(
              color: Colors.grey.withOpacity(0.0),
              height: 25.0,
            ),
            Container(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Korisničko ime:',
                        style: _labelStyle,
                      ),
                      Text(
                        korisnikResult.korisnickoIme,
                        style: _contentStyle,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[400],
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Email:',
                        style: _labelStyle,
                      ),
                      Text(
                        korisnikResult.email ?? "",
                        style: _contentStyle,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[400],
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Kontakt telefon:',
                        style: _labelStyle,
                      ),
                      Text(
                        korisnikResult.brojTelefona ?? "",
                        style: _contentStyle,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[400],
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Adresa:',
                        style: _labelStyle,
                      ),
                      Text(
                        korisnikResult.adresa ?? "",
                        style: _contentStyle,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[400],
                    height: 25.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Mjesto boravka:',
                        style: _labelStyle,
                      ),
                      Text(
                        korisnikResult.gradNaziv ?? "",
                        style: _contentStyle,
                      ),
                    ],
                  ),
                  Divider(
                    color: Colors.grey[400],
                    height: 25.0,
                  ),
                ],
              ),
            ),
            _buildEditProfil(context),
            _buildLogOut(context),
          ],
        ),
      );
    }
  }*/

  /*ListTile _buildLogOut(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.logout,
        size: 27.0,
      ),
      title: Text(
        'Odjava',
        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[800]),
      ),
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const LoginScreen()),
            (route) => false);
      },
    );
  }

  ListTile _buildEditProfil(BuildContext context) {
    return ListTile(
      leading: const Icon(
        Icons.edit_note,
        size: 27.0,
      ),
      title: Text(
        'Uredi profil',
        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[800]),
      ),
      trailing: const Icon(Icons.navigate_next),
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProfilEditScreen(korisnik: korisnikResult)))
            .then((value) => fetchKorisnik());
      },
    );
  }

  Center _buildProfilImage(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(100),
            ),
            child: korisnikResult.slika != "" && korisnikResult.slika != null
                ? GestureDetector(
                    onTap: () {
                      _deleteProfileImage(context);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: MemoryImage(
                          base64Decode(korisnikResult.slika.toString()),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: const Image(
                      image: AssetImage('assets/images/person_icon.png'),
                    ),
                  ),
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.8),
              ),
              child: IconButton(
                onPressed: () async {
                  try {
                    await _getImage();

                    if (_image != null) {
                      KorisnikUpdateRequest request = KorisnikUpdateRequest(
                          korisnikResult.ime,
                          korisnikResult.prezime,
                          korisnikResult.korisnickoIme,
                          korisnikResult.email!,
                          korisnikResult.adresa,
                          korisnikResult.brojTelefona,
                          korisnikResult.status,
                          _base64Image,
                          korisnikResult.gradId,
                          "",
                          "");

                      await _korisnikProvider.update(
                          korisnikResult.korisniciId, request);

                      // ignore: use_build_context_synchronously
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: const Text('Poruka'),
                                content: const Text(
                                    'Profilna slika uspješno izmjenjena !.'),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      var data = await _korisnikProvider
                                          .getById(korisnikResult.korisniciId);

                                      setState(() {
                                        korisnikResult = data;
                                      });
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    }
                  } on Exception catch (e) {
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text("Error"),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("OK"))
                        ],
                      ),
                    );
                  }
                },
                icon: const Icon(
                  Icons.camera_alt,
                  size: 27.0,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _deleteProfileImage(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text(
                'Profilna slika',
                textAlign: TextAlign.center,
              ),
              content: Image(
                image: MemoryImage(
                  base64Decode(korisnikResult.slika.toString()),
                ),
                fit: BoxFit.contain,
              ),
              actions: [
                TextButton.icon(
                  onPressed: () async {
                    try {
                      _base64Image = null;

                      KorisnikUpdateRequest request = KorisnikUpdateRequest(
                          korisnikResult.ime,
                          korisnikResult.prezime,
                          korisnikResult.korisnickoIme,
                          korisnikResult.email!,
                          korisnikResult.adresa,
                          korisnikResult.brojTelefona,
                          korisnikResult.status,
                          _base64Image,
                          korisnikResult.gradId,
                          "",
                          "");

                      await _korisnikProvider.update(
                          korisnikResult.korisniciId, request);

                      var data = await _korisnikProvider
                          .getById(korisnikResult.korisniciId);

                      setState(() {
                        korisnikResult = data;
                      });

                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    } on Exception catch (e) {
                      // ignore: use_build_context_synchronously
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text("Error"),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("OK"))
                          ],
                        ),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey[400],
                      iconColor: Colors.black),
                  icon: const Icon(Icons.delete_forever),
                  label: const Text(
                    'Ukloni sliku',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ));
  }*/
}
