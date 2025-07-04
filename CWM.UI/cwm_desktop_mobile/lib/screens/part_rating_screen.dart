import 'dart:async';
import 'package:advanced_datatable/datatable.dart';
import 'package:cwm_desktop_mobile/data_table_sources/part_work_order_data_table_source.dart';
import 'package:cwm_desktop_mobile/models/part.dart';
import 'package:cwm_desktop_mobile/models/searches/user_rating_search.dart';
import 'package:cwm_desktop_mobile/models/user.dart';
import 'package:cwm_desktop_mobile/providers/part_provider.dart';
import 'package:cwm_desktop_mobile/providers/part_work_order_provider.dart';
import 'package:cwm_desktop_mobile/providers/user_provider.dart';
import 'package:cwm_desktop_mobile/providers/user_rating_provider.dart';
import 'package:cwm_desktop_mobile/utils/utils.dart';
import 'package:cwm_desktop_mobile/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';

import '../models/paged_result.dart';
import '../widgets/responsive.dart';

class PartRatingScreen extends StatefulWidget {
  const PartRatingScreen({super.key});

  @override
  State<PartRatingScreen> createState() => _PartRatingScreenState();
}

class _PartRatingScreenState extends State<PartRatingScreen> {
  late PartWorkOrderProvider _partWorkOrderProvider;
  late UserProvider _userProvider;
  late PartProvider _partProvider;
  late UserRatingProvider _userRatingProvider;

  late PartWorkOrderDataTableSource partWorkOrderDataTableSource;

  final _formKey = GlobalKey<FormBuilderState>();
  var _users = PagedResult<User>();
  var _parts = PagedResult<Part>();

  @override
  void initState() {
    super.initState();

    _partWorkOrderProvider = context.read<PartWorkOrderProvider>();
    _userRatingProvider = context.read<UserRatingProvider>();
    _userProvider = context.read<UserProvider>();
    _partProvider = context.read<PartProvider>();

    partWorkOrderDataTableSource =
        PartWorkOrderDataTableSource(_partWorkOrderProvider, _openDialog);

    _loadData(null);
  }

  Future _loadData(int? id) async {
    var userRatingSearch = UserRatingSearch();
    _users = await _userProvider.getAll();
    _parts = await _partProvider.getAll();
    if (id != null) {
      var partWorkOrder = await _partWorkOrderProvider.get(id);
      userRatingSearch.partId = partWorkOrder.part?.id;
      var userRating =
          await _userRatingProvider.getAll(search: userRatingSearch);

      _formKey.currentState?.patchValue({
        "productRating": userRating.result.first.productRating.toString(),
        "userId": Authorization.userId?.toString() ?? "0",
        "partId": partWorkOrder.part?.id.toString() ?? "0"
      });
    }
  }

  void _openDialog(int? id) {
    showDialog(
      context: context,
      builder: (BuildContext context) => _buildDialog(context, id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search(
          "Dodaj recenziju",
          () => _openDialog(null),
          onSearch: (text) => partWorkOrderDataTableSource.filterData(text),
          hideButton: true,
        ),
        SizedBox(
          width: double.infinity,
          child: AdvancedPaginatedDataTable(
            showHorizontalScrollbarAlways: Responsive.isMobile(context),
            addEmptyRows: false,
            showCheckboxColumn: false,
            source: partWorkOrderDataTableSource,
            rowsPerPage: 7,
            columns: const [
              DataColumn(label: Text("Naziv")),
              DataColumn(label: Text("Proizvodjac")),
              DataColumn(label: Text("Cijena"))
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
            Text(id == null ? "Dodaj recenziju" : "Uredi recenziju"),
          ],
        ),
      ),
      content: SizedBox(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: SizedBox(
              height: Responsive.isDesktop(context)
                  ? 500
                  : MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: Responsive.isDesktop(context)
                        ? 500
                        : MediaQuery.of(context).size.width,
                    child: FormBuilderTextField(
                      name: "productRating",
                      decoration: const InputDecoration(
                          labelText: "Ocjena proizvoda *"),
                      validator: (value) {
                        if (int.parse(value!) > 5 || int.parse(value) <= 0) {
                          return 'Ocjena mora biti izmedju 0 i 5';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: Responsive.isDesktop(context)
                        ? 500
                        : MediaQuery.of(context).size.width,
                    child: FormBuilderDropdown(
                      enabled: false,
                      name: "userId",
                      decoration:
                          const InputDecoration(labelText: "Korisnik *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Korisnik je obavezan."),
                      items: _users.result
                          .map((user) => DropdownMenuItem(
                                value: user.id.toString(),
                                child:
                                    Text("${user.firstName} ${user.lastName}"),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: Responsive.isDesktop(context)
                        ? 500
                        : MediaQuery.of(context).size.width,
                    child: FormBuilderDropdown(
                      enabled: false,
                      name: "partId",
                      decoration:
                          const InputDecoration(labelText: "Dijelovi *"),
                      validator: FormBuilderValidators.required(
                          errorText: "Dio je obavezan."),
                      items: _parts.result
                          .map((part) => DropdownMenuItem(
                                value: part.id.toString(),
                                child: Text(part.partName),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          minimumSize:
                              WidgetStatePropertyAll(Size.fromHeight(50))),
                      child: const Text(
                        "NAZAD",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  if (Responsive.isDesktop(context)) const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          minimumSize:
                              const WidgetStatePropertyAll(Size.fromHeight(50)),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.red)),
                      child: const Text(
                        "OBRIŠI",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onPressed: () async {
                        await _userRatingProvider.delete(id!);
                        await _loadData(null);
                        setState(() {});
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
                        if (context.mounted) Navigator.pop(context);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          minimumSize:
                              const WidgetStatePropertyAll(Size.fromHeight(50)),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.green)),
                      child: const Text(
                        "SPREMI",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                      onPressed: () async {
                        var isValid = _formKey.currentState?.saveAndValidate();

                        if (isValid!) {
                          var request = Map.from(_formKey.currentState!.value);

                          id == null
                              ? await _userRatingProvider.insert(request)
                              : await _userRatingProvider.update(id, request);

                          await _loadData(null);
                          setState(() {});
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
