import 'package:cwm_desktop_mobile/models/city.dart';
import 'package:cwm_desktop_mobile/models/country.dart';
import 'package:cwm_desktop_mobile/models/enums/gender.dart';
import 'package:cwm_desktop_mobile/models/paged_result.dart';
import 'package:cwm_desktop_mobile/models/requests/user_insert_update.dart';
import 'package:cwm_desktop_mobile/providers/city_provider.dart';
import 'package:cwm_desktop_mobile/providers/country_provider.dart';
import 'package:cwm_desktop_mobile/providers/user_provider.dart';
import 'package:cwm_desktop_mobile/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var _gradovi = PagedResult<City>();
  var _drzave = PagedResult<Country>();
  late CityProvider _cityProvider;
  late CountryProvider _countryProvider;
  late UserProvider _userProvider;
  bool isLoading = true;
  Map<String, dynamic> _initialValue = {};

  final TextEditingController _imeController = TextEditingController();
  final TextEditingController _prezimeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _adresaController = TextEditingController();
  final TextEditingController _brojTelefonaController = TextEditingController();
  final TextEditingController _korisnickoImeController =
      TextEditingController();
  final TextEditingController _lozinkaController = TextEditingController();
  final TextEditingController _lozinkaPotvrdaController =
      TextEditingController();
  String? selectedGradNaziv;
  var gender;
  DateTime? selectedDate;
  String? selectedDrzavaNaziv;
  String? selectedGradId;
  String? selectedDrzavaId;
  bool status = true;

  bool isImeValid = true;
  bool isPrezimeValid = true;
  bool isEmailValid = true;
  bool isAdresaValid = true;
  bool isBrojTelefonaValid = true;
  bool isKorisnickoImeValid = true;
  bool isMjestoBoravkaValid = false;
  bool isLozinkaValid = true;
  bool isLozinkaPotvrdaValid = true;

  @override
  void initState() {
    super.initState();

    _cityProvider = context.read<CityProvider>();
    _countryProvider = context.read<CountryProvider>();
    _userProvider = context.read<UserProvider>();

    fetchGradove();
  }

  Future fetchGradove() async {
    _gradovi = await _cityProvider.getAll();
    _drzave = await _countryProvider.getAll();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _selectedDate() async {
    DateTime? selected = await showDatePicker(
        context: context, firstDate: DateTime(1900), lastDate: DateTime(2100));
    if (selected != null) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Registracija'),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Unesite lične podatke',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _imeController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white30,
                            labelText: 'Ime',
                            prefixIcon: const Icon(Icons.person),
                            floatingLabelStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                            errorText: isImeValid
                                ? null
                                : "Unesite ispravne podatke za ime"),
                        onChanged: (value) {
                          bool isValid = Validators.validirajIme(value);
                          setState(() {
                            isImeValid = isValid;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _prezimeController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white30,
                            labelText: 'Prezime',
                            prefixIcon: const Icon(Icons.person),
                            floatingLabelStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                            errorText: isPrezimeValid
                                ? null
                                : "Unesite ispravne podatke za prezime"),
                        onChanged: (value) {
                          bool isValid = Validators.validirajPrezime(value);
                          setState(() {
                            isPrezimeValid = isValid;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white30,
                            labelText: 'Email',
                            prefixIcon: const Icon(Icons.alternate_email),
                            floatingLabelStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                            errorText:
                                isEmailValid ? null : "Unesite ispravno email"),
                        onChanged: (value) {
                          bool isValid = Validators.validirajEmail(value);
                          setState(() {
                            isEmailValid = isValid;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _adresaController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white30,
                          labelText: 'Adresa (opcionalno)',
                          prefixIcon: const Icon(Icons.location_on),
                          floatingLabelStyle: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _brojTelefonaController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white30,
                            labelText: 'Broj telefona (opcionalno)',
                            prefixIcon: const Icon(Icons.phone),
                            floatingLabelStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                            errorText: isBrojTelefonaValid
                                ? null
                                : "Unesite ispravan format broja telefona.\nExample: (06XXXXX)"),
                        onChanged: (value) {
                          bool isValid =
                              Validators.validirajBrojTelefona(value);
                          setState(() {
                            isBrojTelefonaValid = isValid;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStateProperty.all<Color>(Colors.green),
                            foregroundColor:
                                WidgetStateProperty.all(Colors.white),
                          ),
                          onPressed: () {
                            _selectedDate();
                          },
                          child: Text("Izaberi datum rodjenja")),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: DropdownButton(
                          value: gender,
                          items: Gender.values
                              .map(
                                (item) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.centerStart,
                                  value: item,
                                  child: Text(item.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                            Gender odabraniSpol = gender;
                            setState(() {
                              gender = odabraniSpol;
                            });
                          },
                          isExpanded: true,
                          hint: const Text('Spol'),
                          icon: const Icon(Icons.location_city),
                        ),
                      ),
                      const Divider(
                        height: 40.0,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: DropdownButton(
                          value: selectedGradNaziv,
                          items: _gradovi.result
                              .map(
                                (item) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.centerStart,
                                  value: item.id.toString(),
                                  child: Text(item.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedGradNaziv = value;
                            });

                            final odabraniGrad = _gradovi.result.firstWhere(
                                (grad) => grad.id.toString() == value);

                            setState(() {
                              selectedGradId = odabraniGrad.id.toString();
                            });
                          },
                          isExpanded: true,
                          hint: const Text('Grad'),
                          icon: const Icon(Icons.location_city),
                        ),
                      ),
                      const Divider(
                        height: 40.0,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: DropdownButton(
                          value: selectedDrzavaNaziv,
                          items: _drzave.result
                              .map(
                                (item) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.centerStart,
                                  value: item.id.toString(),
                                  child: Text(item.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedDrzavaNaziv = value;
                            });

                            final odabranaDrzava = _drzave.result.firstWhere(
                                (grad) => grad.id.toString() == value);

                            setState(() {
                              selectedDrzavaId = odabranaDrzava.id.toString();
                            });
                          },
                          isExpanded: true,
                          hint: const Text('Drzava'),
                          icon: const Icon(Icons.location_city),
                        ),
                      ),
                      const Divider(
                        height: 40.0,
                      ),
                      TextField(
                        controller: _korisnickoImeController,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(10.0),
                            border: const OutlineInputBorder(),
                            focusedBorder: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.white30,
                            labelText: 'Korisničko ime',
                            prefixIcon: const Icon(Icons.email),
                            floatingLabelStyle: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500),
                            errorText: isKorisnickoImeValid
                                ? null
                                : "Unesite ispravno korisnicko ime."),
                        onChanged: (value) {
                          bool isValid =
                              Validators.validirajKorisnickoIme(value);
                          setState(() {
                            isKorisnickoImeValid = isValid;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _lozinkaController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white30,
                          labelText: 'Lozinka',
                          prefixIcon: const Icon(Icons.password),
                          floatingLabelStyle: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                          errorText: isLozinkaValid
                              ? null
                              : 'Lozinka mora sadržavati minimalno 4 znaka!',
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (value.length >= 4 && value.isNotEmpty) {
                              isLozinkaValid = true;
                            } else {
                              isLozinkaValid = false;
                            }
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextField(
                        controller: _lozinkaPotvrdaController,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10.0),
                          border: const OutlineInputBorder(),
                          focusedBorder: const OutlineInputBorder(),
                          filled: true,
                          fillColor: Colors.white30,
                          labelText: 'Lozinka potvrda',
                          prefixIcon: const Icon(Icons.password),
                          floatingLabelStyle: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500),
                          errorText: isLozinkaValid
                              ? null
                              : 'Lozinke se ne podudaraju!',
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (_lozinkaController.text.isNotEmpty &&
                                _lozinkaController.text == value) {
                              isLozinkaValid = true;
                            } else {
                              isLozinkaValid = false;
                            }
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      /*IgnorePointer(
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Status',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54),
                              ),
                              const SizedBox(height: 5.0),
                              Switch(
                                value: status,
                                onChanged: (newValue) {
                                  setState(() {
                                    status = newValue;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),*/
                      const SizedBox(
                        height: 20.0,
                      ),
                      _buildSaveButton(context),
                    ],
                  ),
                ),
              ));
  }

  ElevatedButton _buildSaveButton(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _imeController.text != "" &&
              _prezimeController.text != "" &&
              _emailController.text != "" &&
              _korisnickoImeController.text != "" &&
              _lozinkaController.text != "" &&
              _lozinkaPotvrdaController.text != "" &&
              selectedDate != null &&
              selectedGradNaziv != null &&
              isPrezimeValid &&
              isEmailValid &&
              isBrojTelefonaValid &&
              isKorisnickoImeValid &&
              isLozinkaValid &&
              isLozinkaPotvrdaValid &&
              isImeValid
          ? () async {
              /*var korisnikProvider =
                  );*/
              //var request;

              UserInsertUpdate request = UserInsertUpdate(
                  _imeController.text,
                  _prezimeController.text,
                  gender,
                  selectedDate!,
                  selectedGradId as String,
                  selectedDrzavaId as String,
                  "",
                  _korisnickoImeController.text,
                  _lozinkaController.text,
                  _emailController.text,
                  _brojTelefonaController.text);
              _initialValue = {
                "firstName": request.firstName,
                "lastName": request.lastName,
                "gender": request.gender.index,
                "birthDate": request.birthDate,
                "cityId": request.cityId,
                "countryId": request.citizenshipId,
                "image": request.image,
                "username": request.username,
                "password": request.password,
                "email": request.email,
                "mobile": request.mobile
              };
              try {
                await _userProvider.insert(_initialValue);

                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: const Text('Registracija uspješna !'),
                          content: const Text(
                              'Vaš korisnički račun je aktiviran i možete se prijaviti na našu platformu koristeći svoje pristupne podatke'),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ));
              } on Exception {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text("Greška"),
                    content: const Text(
                        "Korisnicko ime vec postoji!\nMolimo da unesete drugo korisničko ime."),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"))
                    ],
                  ),
                );
              }
            }
          : null,
      style: ElevatedButton.styleFrom(
          elevation: 5.0,
          backgroundColor: Colors.blue.shade200,
          foregroundColor: Colors.black),
      label: const Text(
        'Spremi',
        style: TextStyle(fontSize: 16),
      ),
      icon: const Icon(
        Icons.save_alt,
        size: 26,
      ),
    );
  }
}
