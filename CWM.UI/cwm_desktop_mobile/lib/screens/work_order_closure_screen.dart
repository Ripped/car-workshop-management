import 'package:cwm_desktop_mobile/models/searches/vehicle_search.dart';
import 'package:cwm_desktop_mobile/providers/work_order_provider.dart';
import 'package:cwm_desktop_mobile/screens/work_order_list_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../models/paged_result.dart';
import '../models/vehicle.dart';
import '../providers/vehicle_provider.dart';
import '../providers/vehicle_service_history_provider.dart';

class WorkOrderClosureScreen extends StatefulWidget {
  final int? id;
  const WorkOrderClosureScreen(this.id, {super.key});

  @override
  State<WorkOrderClosureScreen> createState() => _WorkOrderClosureScreen();
}

class _WorkOrderClosureScreen extends State<WorkOrderClosureScreen> {
  late WorkOrderProvider _workOrderProvider;
  late VehicleServiceHistoryProvider _vehicleServiceHistoryProvider;
  late VehicleProvider _vehicleProvider;

  bool isLoading = true;
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  var _vehicles = PagedResult<Vehicle>();

  @override
  void initState() {
    super.initState();

    _workOrderProvider = context.read<WorkOrderProvider>();
    _vehicleServiceHistoryProvider =
        context.read<VehicleServiceHistoryProvider>();
    _vehicleProvider = context.read<VehicleProvider>();

    _loadData(widget.id);
  }

  Future _loadData(int? id) async {
    var vehicleSearch = VehicleSearch();
    vehicleSearch.pageSize = 50;

    _vehicles = await _vehicleProvider.getAll(search: vehicleSearch);

    if (id != null) {
      var workOrder = await _workOrderProvider.get(id);

      _initialValue = {
        "serviceType": workOrder.servicePerformed.index,
        "serviceDate": workOrder.startTime,
        "vehicleId": workOrder.vehicle!.id
      };
    } else {
      _initialValue = {"image": "", "description": ""};
    }
    setState(() {
      isLoading = false;
    });
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
                "Zatvaranje radnog naloga",
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
                  child: FormBuilderDateTimePicker(
                    name: "serviceDate",
                    decoration: const InputDecoration(
                        labelText: "Datum rada na vozilu *"),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: FormBuilderDropdown(
                        name: "serviceType",
                        decoration:
                            const InputDecoration(labelText: "Vrsta servisa *"),
                        items: const [
                          DropdownMenuItem(
                            value: 0,
                            child: Text("Elektrika"),
                          ),
                          DropdownMenuItem(
                            value: 1,
                            child: Text("Mehanicar"),
                          ),
                          DropdownMenuItem(
                            value: 2,
                            child: Text("Limarija"),
                          ),
                          DropdownMenuItem(
                            value: 3,
                            child: Text("Podvozje"),
                          ),
                          DropdownMenuItem(
                            value: 4,
                            child: Text("Pregled"),
                          ),
                          DropdownMenuItem(
                            value: 5,
                            child: Text("Ostalo"),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FormBuilderTextField(
                    name: "description",
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: const InputDecoration(
                        labelText: "Opis kvara vlasnika vozila  *"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FormBuilderDropdown(
                      name: "vehicleId",
                      enabled: false,
                      decoration: const InputDecoration(labelText: "Vozilo *"),
                      items: _vehicles.result
                          .map((vehicle) => DropdownMenuItem(
                                value: vehicle.id,
                                child: Text(vehicle.chassis),
                              ))
                          .toList(),
                    ),
                  ),
                ),
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
                        child:
                            const Text("SPREMI", textAlign: TextAlign.center),
                        onPressed: () async {
                          var isValid =
                              _formKey.currentState?.saveAndValidate();

                          if (isValid!) {
                            var request =
                                Map.from(_formKey.currentState!.value);

                            widget.id == null
                                ? await _vehicleServiceHistoryProvider
                                    .insert(request)
                                : await _vehicleServiceHistoryProvider.update(
                                    widget.id!, request);

                            if (!context.mounted) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const MasterScreen(
                                          "Termini", WorkOrderListScreen())));
                            }
                          }
                        },
                      ),
                    ])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
