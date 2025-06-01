import 'package:cwm_desktop_mobile/screens/report_employee_screen.dart';
import 'package:cwm_desktop_mobile/screens/report_finance_screen.dart';
import 'package:cwm_desktop_mobile/screens/report_order_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Izvještaj'),
        ),
        body: Center(
            child: Row(
          children: [
            SizedBox(
              width: 80,
            ),
            Card(
                color: Colors.white,
                child: SizedBox(
                  width: 400,
                  height: 500,
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
                          width: 250,
                          height: 300,
                          child: Icon(
                            Icons.content_paste,
                            size: 150,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Radnici izvjestaj",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 80),
                        ),
                        child: const Text("OTVORI",
                            style: TextStyle(fontSize: 30)),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const MasterScreen(
                                      "Radnici", ReportEmployeeScreen())));
                        },
                      )
                    ],
                  ),
                )),
            SizedBox(
              width: 80,
            ),
            Card(
                color: Colors.white,
                child: SizedBox(
                  width: 400,
                  height: 500,
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
                          width: 250,
                          height: 300,
                          child: Icon(
                            Icons.content_paste,
                            size: 150,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Finansijski izvjestaj",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 80),
                        ),
                        child: const Text("OTVORI",
                            style: TextStyle(fontSize: 30)),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const MasterScreen(
                                      "Finansije", ReportFinanceScreen())));
                        },
                      )
                    ],
                  ),
                )),
            SizedBox(
              width: 80,
            ),
            Card(
                color: Colors.white,
                child: SizedBox(
                  width: 400,
                  height: 500,
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
                          width: 250,
                          height: 300,
                          child: Icon(
                            Icons.content_paste,
                            size: 150,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text("Narudzbe izvjestaj",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 40, horizontal: 80),
                        ),
                        child: const Text("OTVORI",
                            style: TextStyle(fontSize: 30)),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const MasterScreen(
                                      "Narudzbe", ReportOrderScreen())));
                        },
                      )
                    ],
                  ),
                )),
          ],
        )));
  }
}
