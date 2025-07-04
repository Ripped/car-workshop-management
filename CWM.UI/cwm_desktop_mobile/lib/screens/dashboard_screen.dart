import 'dart:convert';

import 'package:cwm_desktop_mobile/models/enums/role.dart';
import 'package:cwm_desktop_mobile/models/part.dart';
import 'package:cwm_desktop_mobile/providers/recommender_provider.dart';
import 'package:cwm_desktop_mobile/screens/appointment_list_screen.dart';
import 'package:cwm_desktop_mobile/screens/appointment_screen_syn_calendar.dart';
import 'package:cwm_desktop_mobile/screens/customer_order_list_screen.dart';
import 'package:cwm_desktop_mobile/screens/employee_list_screen.dart';
import 'package:cwm_desktop_mobile/screens/part_details_screen.dart';
import 'package:cwm_desktop_mobile/screens/part_rating_screen.dart';
import 'package:cwm_desktop_mobile/screens/vehicle_list.dart';
import 'package:cwm_desktop_mobile/screens/vehicle_list_screen.dart';
import 'package:cwm_desktop_mobile/utils/utils.dart';
import 'package:cwm_desktop_mobile/widgets/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/master_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  late RecommenderProvider _recommendProvider;
  List<dynamic>? recommendedParts;
  List<Part>? parts = [];
  bool isLoading = true;

  Future _loadData(int? id) async {
    if (id != null) {
      parts = (await _recommendProvider.getRecommendParts(id)).cast<Part>();
    }
    if (parts!.isEmpty) {
      setState(() {
        isLoading = true;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _recommendProvider = context.read<RecommenderProvider>();

    _loadData(Authorization.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? SingleChildScrollView(
              child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  spacing: 40,
                  runSpacing: 60,
                  children: [
                  Card(
                      color: Colors.white,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.content_paste,
                                  size: 40,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text("Pocetna"),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text("OTVORI"),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MasterScreen("Dashboard",
                                                DashboardScreen())));
                              },
                            )
                          ],
                        ),
                      )),
                  Card(
                      color: Colors.white,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.content_paste,
                                  size: 40,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text("Rezervacija termina"),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text("OTVORI"),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MasterScreen(
                                                "Rezervacija termina",
                                                MyWidget())));
                              },
                            )
                          ],
                        ),
                      )),
                  Card(
                      color: Colors.white,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.content_paste,
                                  size: 40,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text("Lista vozila"),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text("OTVORI"),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MasterScreen("Lista vozila",
                                                VehicleScreen())));
                              },
                            )
                          ],
                        ),
                      )),
                  Card(
                      color: Colors.white,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.content_paste,
                                  size: 40,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text("Pregled narudzbi"),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text("OTVORI"),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MasterScreen(
                                                "Pregled narudzbi",
                                                CustomerOrderListScreen())));
                              },
                            )
                          ],
                        ),
                      )),
                  Card(
                      color: Colors.white,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.content_paste,
                                  size: 40,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text("Historija vozila"),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text("OTVORI"),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MasterScreen(
                                                "Historija vozila",
                                                VehicleListScreen())));
                              },
                            )
                          ],
                        ),
                      )),
                  Card(
                      color: Colors.white,
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(50)),
                              child: const SizedBox(
                                width: 100,
                                height: 100,
                                child: Icon(
                                  Icons.content_paste,
                                  size: 40,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text("Recenzija dijelova"),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text("OTVORI"),
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MasterScreen(
                                                "Recenzija dijelova",
                                                PartRatingScreen())));
                              },
                            )
                          ],
                        ),
                      )),
                  if (Authorization.roles.contains(Role.admin))
                    Card(
                        color: Colors.white,
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(50)),
                                child: const SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Icon(
                                    Icons.content_paste,
                                    size: 40,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text("Rezervacija termina"),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                child: const Text("OTVORI"),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MasterScreen("Zaposlenici",
                                                  EmployeeListScreen())));
                                },
                              )
                            ],
                          ),
                        )),
                  if (Authorization.roles.contains(Role.admin))
                    Card(
                        color: Colors.white,
                        child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(50)),
                                child: const SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Icon(
                                    Icons.content_paste,
                                    size: 40,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text("Pregled termina"),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                child: const Text("OTVORI"),
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MasterScreen(
                                                  "Pregled termina",
                                                  AppointmentListScreen())));
                                },
                              )
                            ],
                          ),
                        )),
                ]))
          : SizedBox(
              height: Responsive.isDesktop(context)
                  ? 400
                  : MediaQuery.of(context).size.height,
              child: GridView.builder(
                shrinkWrap: true,
                scrollDirection: Responsive.isDesktop(context)
                    ? Axis.horizontal
                    : Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 4 / 3,
                ),
                itemCount: parts!.length,
                itemBuilder: _buildListRecommendedProizvodi,
              ),
            ),
    );
  }

  Widget? _buildListRecommendedProizvodi(BuildContext context, int index) {
    Part proizvod = parts![index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    MasterScreen("Proizvod", PartDetailsScreen(proizvod.id))));
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.blueGrey,
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(3, 4)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: proizvod.image != "" && proizvod.image != null
                  ? Image(
                      width: 100,
                      height: 250,
                      fit: BoxFit.cover,
                      image: MemoryImage(
                        base64Decode(
                          proizvod.image.toString(),
                        ),
                      ),
                    )
                  : Image(
                      width: 100,
                      height: Responsive.isDesktop(context)
                          ? 250
                          : MediaQuery.of(context).size.height / 4,
                      fit: BoxFit.cover,
                      image:
                          AssetImage('assets/images/image_not_available.png'),
                    ),
            ),
            const SizedBox(
              height: 2.0,
            ),
            Text(
              proizvod.partName,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700]),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              proizvod.serialNumber,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800]),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Text(
              '${formatNumber(proizvod.price)} KM',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
