import 'package:cwm_desktop_mobile/models/paged_result.dart';
import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:cwm_desktop_mobile/providers/user_provider.dart';
import 'package:cwm_desktop_mobile/providers/vehicle_provider.dart';
import 'package:cwm_desktop_mobile/screens/parts_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
      _initialValue = {"chassis": "", "model": ""};
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
                          /*if (Responsive.isDesktop(context))
                            SizedBox(
                                child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
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
                                            "assets/images/image_not_available.png",
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
                                    "Slika dijela",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ])),*/
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
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: FormBuilderDropdown(
                                      name: "userId",
                                      decoration: const InputDecoration(
                                          labelText: "Korisnik"),
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
