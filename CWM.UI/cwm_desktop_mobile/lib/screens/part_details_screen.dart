import 'dart:convert';
import 'dart:io';

import 'package:cwm_desktop_mobile/providers/part_provider.dart';
import 'package:cwm_desktop_mobile/screens/parts_list_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../widgets/master_screen.dart';
import '../widgets/responsive.dart';

class PartDetailsScreen extends StatefulWidget {
  final int? id;
  const PartDetailsScreen(this.id, {super.key});

  @override
  State<PartDetailsScreen> createState() => _PartDetailsScreenState();
}

class _PartDetailsScreenState extends State<PartDetailsScreen> {
  late PartProvider _partProvider;

  bool isLoading = true;
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _initialValue = {};

  @override
  void initState() {
    super.initState();

    _partProvider = context.read<PartProvider>();

    _loadData(widget.id);
  }

  Future _loadData(int? id) async {
    if (id != null) {
      var part = await _partProvider.get(id);

      _initialValue = {
        "serialNumber": part.serialNumber,
        "manufacturer": part.manufacturer,
        "partName": part.partName,
        "image": part.image,
        "price": part.price.toString(),
        "description": part.description
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
                      child: Column(
                        children: [
                          Card(
                            margin: const EdgeInsets.all(10),
                            color: Theme.of(context).primaryColor,
                            child: const SizedBox(
                              width: 800,
                              height: 30,
                              child: Text(
                                "Podaci o dijelu",
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
                            ])),
                          SizedBox(
                            height: Responsive.isDesktop(context)
                                ? (MediaQuery.of(context).size.width / 6)
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
                                      name: "serialNumber",
                                      decoration: const InputDecoration(
                                          labelText: "Serijski broj *"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FormBuilderTextField(
                                      name: "manufacturer",
                                      decoration: const InputDecoration(
                                          labelText: "Proizvodjac *"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FormBuilderTextField(
                                      name: "partName",
                                      decoration: const InputDecoration(
                                          labelText: "Ime dijela *"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FormBuilderTextField(
                                      name: "price",
                                      decoration: const InputDecoration(
                                          labelText: "Cijena *"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FormBuilderTextField(
                                      name: "description",
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 3,
                                      decoration: const InputDecoration(
                                          labelText: "Opis dijela  *"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: FormBuilderField(
                                      name: 'image',
                                      builder: ((field) {
                                        return InputDecorator(
                                          decoration: InputDecoration(
                                              errorText: field.errorText),
                                          child: ListTile(
                                            leading: const Icon(Icons.photo),
                                            title:
                                                const Text("Odaberite sliku"),
                                            trailing:
                                                const Icon(Icons.file_upload),
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
                                                  ? await _partProvider
                                                      .insert(request)
                                                  : await _partProvider.update(
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
                                            await _partProvider
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
                                                    ? await _partProvider
                                                        .insert(request)
                                                    : await _partProvider
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
                                              await _partProvider
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
                "Radni Nalog",
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FormBuilderTextField(
                      name: "serialNumber",
                      decoration:
                          const InputDecoration(labelText: "Serijski broj *"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FormBuilderTextField(
                      name: "manufacturer",
                      decoration:
                          const InputDecoration(labelText: "Proizvodjac *"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FormBuilderTextField(
                      name: "partName",
                      decoration:
                          const InputDecoration(labelText: "Ime dijela *"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FormBuilderTextField(
                      name: "price",
                      decoration: const InputDecoration(labelText: "Cijena *"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: FormBuilderTextField(
                      name: "description",
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      decoration:
                          const InputDecoration(labelText: "Opis dijela  *"),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(0),
                    child: Column(children: <Widget>[
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize:
                              const WidgetStatePropertyAll(Size.fromHeight(50)),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.green),
                          foregroundColor:
                              WidgetStateProperty.all(Colors.white),
                        ),
                        child:
                            const Text("SPREMI", textAlign: TextAlign.center),
                        onPressed: () async {
                          var isValid =
                              _formKey.currentState?.saveAndValidate();

                          if (isValid!) {
                            var request =
                                Map.from(_formKey.currentState!.value);

                            widget.id == null
                                ? await _partProvider.insert(request)
                                : await _partProvider.update(
                                    widget.id!, request);

                            if (context.mounted) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const MasterScreen(
                                          "Uspolenici", PartListScreen())));
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ButtonStyle(
                          minimumSize:
                              const WidgetStatePropertyAll(Size.fromHeight(50)),
                          backgroundColor:
                              WidgetStateProperty.all<Color>(Colors.red),
                          foregroundColor:
                              WidgetStateProperty.all(Colors.white),
                        ),
                        child: const Text("OBRIŠI"),
                        onPressed: () async {
                          await _partProvider.delete(widget.id!);
                          await _loadData(null);
                          setState(() {});
                          if (context.mounted) {
                            Navigator.pop(context);
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
                  "Slika dijela",
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
                      minimumSize: WidgetStatePropertyAll(Size.fromHeight(50))),
                  child: const Text("SPREMI", textAlign: TextAlign.center),
                  onPressed: () async {
                    var isValid = _formKey.currentState?.saveAndValidate();

                    if (isValid!) {
                      var request = Map.from(_formKey.currentState!.value);

                      widget.id == null
                          ? await _partProvider.insert(request)
                          : await _partProvider.update(widget.id!, request);

                      if (context.mounted) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const MasterScreen(
                                "Dijelovi", PartListScreen())));
                      }
                    }
                  },
                ),
              ])),
        ]));
  }
}
