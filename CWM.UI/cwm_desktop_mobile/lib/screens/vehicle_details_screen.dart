import 'package:cwm_desktop_mobile/models/paged_result.dart';
import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:cwm_desktop_mobile/providers/user_provider.dart';
import 'package:cwm_desktop_mobile/providers/vehicle_provider.dart';
import 'package:cwm_desktop_mobile/screens/parts_list_screen.dart';
import 'package:cwm_desktop_mobile/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../widgets/master_screen.dart';
import '../widgets/responsive.dart';

class VehicleDetailsScreen extends StatefulWidget {
  final int? id;
  const VehicleDetailsScreen(this.id, {super.key});

  @override
  State<VehicleDetailsScreen> createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  late VehicleProvider _vehicleProvider;
  late UserProvider _userProvider;

  bool isLoading = true;
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};
  var _users = PagedResult<User>();

  @override
  void initState() {
    super.initState();

    _vehicleProvider = context.read<VehicleProvider>();
    _userProvider = context.read<UserProvider>();

    _loadData(widget.id);
  }

  Future _loadData(int? id) async {
    _users = await _userProvider.getAll();

    if (id != null) {
      var vehicle = await _vehicleProvider.get(id);

      _initialValue = {
        "chassis": vehicle.chassis,
        "brand": vehicle.brand,
        "model": vehicle.model,
        "cubicCapacity": vehicle.cubicCapacity.toString(),
        "kilowatts": vehicle.kilowatts.toString(),
        "transmision": vehicle.transmision,
        "productionDate": vehicle.productionDate,
        "fuel": vehicle.fuel,
        "userId": vehicle.user!.id
      };
    } else {
      _initialValue = {
        "userId": Authorization.userId,
        "model": "",
      };
    }
    setState(() {
      isLoading = false;
    });
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
                      child: Column(
                        children: [
                          Card(
                            margin: const EdgeInsets.all(10),
                            color: Theme.of(context).primaryColor,
                            child: const SizedBox(
                              width: 800,
                              height: 30,
                              child: Text(
                                "Podaci o vozilu",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Responsive.isDesktop(context)
                                ? (MediaQuery.of(context).size.width / 3)
                                : (MediaQuery.of(context).size.height / 1.4),
                            child: GridView.count(
                              crossAxisCount: Responsive.isDesktop(context)
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
                                    alignment: Alignment.bottomCenter,
                                    child: FormBuilderTextField(
                                      name: "chassis",
                                      decoration: const InputDecoration(
                                          labelText: "Sasija *"),
                                      validator: FormBuilderValidators.required(
                                          errorText: "Sasija je obavezna."),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FormBuilderTextField(
                                      name: "brand",
                                      decoration: const InputDecoration(
                                          labelText: "Brend vozila *"),
                                      validator: FormBuilderValidators.required(
                                          errorText: "Brend je obavezan."),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FormBuilderTextField(
                                      name: "model",
                                      decoration: const InputDecoration(
                                          labelText: "Model vozila *"),
                                      validator: FormBuilderValidators.required(
                                          errorText: "Model je obavezan."),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FormBuilderTextField(
                                      name: "cubicCapacity",
                                      decoration: const InputDecoration(
                                          labelText: "Kubikaza *"),
                                      validator: FormBuilderValidators.required(
                                          errorText: "Kubikaza je obavezna."),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FormBuilderTextField(
                                      name: "kilowatts",
                                      decoration: const InputDecoration(
                                          labelText: "Kilovati  *"),
                                      validator: FormBuilderValidators.required(
                                          errorText: "Kilovati je obavezni."),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FormBuilderTextField(
                                      name: "transmision",
                                      decoration: const InputDecoration(
                                          labelText: "Mjenjac  *"),
                                      validator: FormBuilderValidators.required(
                                          errorText: "Mjenjac je obavezan."),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FormBuilderDateTimePicker(
                                      name: "productionDate",
                                      decoration: const InputDecoration(
                                          labelText: "Datum proizvodnje *"),
                                      validator: FormBuilderValidators.required(
                                          errorText:
                                              "Datum proizvodnje je obavezan."),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FormBuilderTextField(
                                      name: "fuel",
                                      decoration: const InputDecoration(
                                          labelText: "Gorivo  *"),
                                      validator: FormBuilderValidators.required(
                                          errorText: "Gorivo je obavezno."),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FormBuilderDropdown(
                                      enabled: false,
                                      name: "userId",
                                      decoration: const InputDecoration(
                                          labelText: "Korisnik"),
                                      validator: FormBuilderValidators.required(
                                          errorText: "Korisnik je obavezan."),
                                      items: _users.result
                                          .map((user) => DropdownMenuItem(
                                                value: user.id,
                                                child: Text(
                                                    "${user.firstName} ${user.lastName}"),
                                              ))
                                          .toList(),
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
                                                WidgetStateProperty.all<Color>(
                                                    Colors.green),
                                            foregroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.white),
                                          ),
                                          child: const Text("SPREMI",
                                              textAlign: TextAlign.center),
                                          onPressed: () async {
                                            var isValid = _formKey.currentState
                                                ?.saveAndValidate();

                                            if (isValid!) {
                                              var request = Map.from(
                                                  _formKey.currentState!.value);

                                              widget.id == null
                                                  ? await _vehicleProvider
                                                      .insert(request)
                                                  : await _vehicleProvider
                                                      .update(
                                                          widget.id!, request);

                                              if (context.mounted) {
                                                Navigator.of(context).pushReplacement(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MasterScreen(
                                                                "Uspolenici",
                                                                PartListScreen())));
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
                                                WidgetStateProperty.all<Color>(
                                                    Colors.red),
                                            foregroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.white),
                                          ),
                                          child: const Text("OBRIŠI"),
                                          onPressed: () async {
                                            await _vehicleProvider
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
                                                      Size.fromHeight(50)),
                                              backgroundColor:
                                                  WidgetStateProperty.all<
                                                      Color>(Colors.green),
                                              foregroundColor:
                                                  WidgetStateProperty.all(
                                                      Colors.white),
                                            ),
                                            child: const Text("SPREMI",
                                                textAlign: TextAlign.center),
                                            onPressed: () async {
                                              var isValid = _formKey
                                                  .currentState
                                                  ?.saveAndValidate();

                                              if (isValid!) {
                                                var request = Map.from(_formKey
                                                    .currentState!.value);

                                                widget.id == null
                                                    ? await _vehicleProvider
                                                        .insert(request)
                                                    : await _vehicleProvider
                                                        .update(widget.id!,
                                                            request);

                                                if (context.mounted) {
                                                  Navigator.of(context).pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MasterScreen(
                                                                  "Uspolenici",
                                                                  PartListScreen())));
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
                                                      Size.fromHeight(40)),
                                              backgroundColor:
                                                  WidgetStateProperty.all<
                                                      Color>(Colors.red),
                                              foregroundColor:
                                                  WidgetStateProperty.all(
                                                      Colors.white),
                                            ),
                                            child: const Text("OBRIŠI"),
                                            onPressed: () async {
                                              await _vehicleProvider
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ))
                  ],
                )),
              ));
  }
}
