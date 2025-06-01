import 'package:cwm_desktop_mobile/models/enums/role.dart';
import 'package:cwm_desktop_mobile/screens/appointment_list_screen.dart';
import 'package:cwm_desktop_mobile/screens/appointment_screen_syn_calendar.dart';
import 'package:cwm_desktop_mobile/screens/customer_order_list_screen.dart';
import 'package:cwm_desktop_mobile/screens/dashboard_screen.dart';
import 'package:cwm_desktop_mobile/screens/employee_list_screen.dart';
import 'package:cwm_desktop_mobile/screens/parts_list_screen.dart';
import 'package:cwm_desktop_mobile/screens/report_employee_screen.dart';
import 'package:cwm_desktop_mobile/screens/report_finance_screen.dart';
import 'package:cwm_desktop_mobile/screens/report_order_screen.dart';
import 'package:cwm_desktop_mobile/screens/report_screen.dart';
import 'package:cwm_desktop_mobile/screens/vehicle_list.dart';
import 'package:cwm_desktop_mobile/screens/work_order_list_screen.dart';
import 'package:cwm_desktop_mobile/widgets/master_screen.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildHeader(context),
            const Divider(
              color: Colors.black,
              indent: 10,
              endIndent: 10,
              thickness: 0.1,
            ),
            buildUser(context),
            const Divider(
              color: Colors.black,
              indent: 10,
              endIndent: 10,
              thickness: 0.1,
            ),
            buildItems(context)
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 10),
        child: Image.asset("assets/images/logo.png", width: 180));
  }

  Widget buildUser(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child:
                    Image.asset("assets/images/default-avatar.png", width: 50)),
            const SizedBox(
              width: 20,
            ),
            Text(
              '${Authorization.username}',
              style: const TextStyle(
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3C4858),
                  fontSize: 16),
            )
          ],
        ));
  }

  Widget buildItems(BuildContext context) {
    double spaceHeight = MediaQuery.of(context).size.height > 545
        ? MediaQuery.of(context).size.height - 545
        : 0;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
        runSpacing: 16,
        children: [
          _buildListTile(context, "Početna", Icons.dashboard,
              const DashboardScreen(), true),
          if (Authorization.roles.contains(Role.employee) ||
              Authorization.roles.contains(Role.admin))
            _buildListTile(context, "Nalozi", Icons.content_paste,
                const WorkOrderListScreen(), true),
          _buildListTile(context, "Dijelovi", Icons.data_array,
              const PartListScreen(), true),
          _buildListTile(
              context, "Report", Icons.data_array, const ReportScreen(), true),
          _buildListTile(context, "Rezervacija termina", Icons.date_range,
              const MyWidget(), true),
          if (Authorization.roles.contains(Role.admin))
            _buildListTile(context, "Pregled termina", Icons.date_range,
                const AppointmentListScreen(), true),
          _buildListTile(context, "Pregled narudzbi", Icons.date_range,
              const CustomerOrderListScreen(), true),
          if (Authorization.roles.contains(Role.admin))
            _buildListTile(context, "Zaposlenici", Icons.date_range,
                const EmployeeListScreen(), true),
          if (Authorization.roles.contains(Role.admin))
            _buildListTile(context, "Historija vozila", Icons.date_range,
                const VehicleListScreen(), true),
          SizedBox(height: spaceHeight),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Postavke"),
            onTap: () {},
          )
        ],
      ),
    );
  }

  ListTile _buildListTile(
    BuildContext context,
    String title,
    IconData icon,
    Widget screen,
    bool enabled,
  ) {
    return ListTile(
      enabled: enabled,
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MasterScreen(title, screen)));
      },
    );
  }
}
