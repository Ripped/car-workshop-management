import 'package:cwm_desktop_mobile/screens/parts_list_screen.dart';
import 'package:cwm_desktop_mobile/screens/work_order_list_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/master_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SizedBox(
          width: double.infinity,
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
                        const Text("Nalozi"),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          child: const Text("OTVORI"),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const MasterScreen(
                                        "Nalozi", WorkOrderListScreen())));
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
                        const Text("Kartica"),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          child: const Text("OTVORI"),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const MasterScreen(
                                        "Dijelovi", PartListScreen())));
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
                        const Text("Kartica"),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          child: const Text("OTVORI"),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const MasterScreen(
                                        "Dijelovi", PartListScreen())));
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
                        const Text("Kartica"),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          child: const Text("OTVORI"),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const MasterScreen(
                                        "Dijelovi", PartListScreen())));
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
                        const Text("Kartica"),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          child: const Text("OTVORI"),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const MasterScreen(
                                        "Dijelovi", PartListScreen())));
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
                        const Text("Dijelovi"),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          child: const Text("OTVORI"),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const MasterScreen(
                                        "Dijelovi", PartListScreen())));
                          },
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
