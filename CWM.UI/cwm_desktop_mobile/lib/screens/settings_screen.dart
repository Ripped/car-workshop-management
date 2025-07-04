import 'package:cwm_desktop_mobile/models/appointment_blocked.dart';
import 'package:cwm_desktop_mobile/models/appointment_type.dart';
import 'package:cwm_desktop_mobile/models/expenses.dart';
import 'package:cwm_desktop_mobile/models/user_role.dart';
import 'package:cwm_desktop_mobile/providers/appointment_blocked_provider.dart';
import 'package:cwm_desktop_mobile/providers/appointment_type_provider.dart';
import 'package:cwm_desktop_mobile/providers/expenses_provider.dart';
import 'package:cwm_desktop_mobile/providers/user_role_provider.dart';
import 'package:cwm_desktop_mobile/screens/appointment_type_list_screen.dart';
import 'package:cwm_desktop_mobile/screens/blocked_dates_screen.dart';
import 'package:cwm_desktop_mobile/screens/expenses_screen.dart';
import 'package:cwm_desktop_mobile/screens/user_role_screen.dart';
import 'package:cwm_desktop_mobile/screens/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/city.dart';
import '../models/country.dart';
import '../models/paged_result.dart';
import '../providers/city_provider.dart';
import '../providers/country_provider.dart';
import '../widgets/master_screen.dart';
import '../widgets/responsive.dart';
import 'city_list_screen.dart';
import 'country_list_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late CityProvider _cityProvider;
  late CountryProvider _countryProvider;
  late AppointmentTypeProvider _appointmentTypeProvider;
  late AppointmentBlockedProvider _appointmentBlockedProvider;
  late ExpensesProvider _expensesProvider;
  late UserRoleProvider _userRoleProvider;

  late var _cities = PagedResult<City>();
  var _countries = PagedResult<Country>();
  var _appointmentTypes = PagedResult<AppointmentType>();
  var _blockedDates = PagedResult<AppointmentBlocked>();
  var _expenses = PagedResult<Expenses>();
  var _userRoles = PagedResult<UserRole>();

  @override
  void initState() {
    super.initState();

    _cityProvider = context.read<CityProvider>();
    _countryProvider = context.read<CountryProvider>();
    _appointmentTypeProvider = context.read<AppointmentTypeProvider>();
    _appointmentBlockedProvider = context.read<AppointmentBlockedProvider>();
    _expensesProvider = context.read<ExpensesProvider>();
    _userRoleProvider = context.read<UserRoleProvider>();

    _loadData(null);
  }

  Future _loadData(int? id) async {
    _cities = await _cityProvider.getAll();
    _countries = await _countryProvider.getAll();
    _appointmentTypes = await _appointmentTypeProvider.getAll();
    _blockedDates = await _appointmentBlockedProvider.getAll();
    _expenses = await _expensesProvider.getAll();
    _userRoles = await _userRoleProvider.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            'Održavanje tabela',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 30),
          FutureBuilder(
            future: _loadData(null),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                if (Responsive.isMobile(context)) {
                  return Column(
                    children: [
                      _buildSettingsBoxContainer(
                        context,
                        "Gradovi",
                        _cities.totalCount.toString(),
                        const CityListScreen(),
                      ),
                      const SizedBox(height: 16),
                      _buildSettingsBoxContainer(
                        context,
                        "Države",
                        _countries.totalCount.toString(),
                        const CountryListScreen(),
                      ),
                      const SizedBox(height: 16),
                      _buildSettingsBoxContainer(
                        context,
                        "Vrste termina",
                        _appointmentTypes.totalCount.toString(),
                        const AppointmentTypeListScreen(),
                      ),
                      const SizedBox(height: 16),
                      _buildSettingsBoxContainer(
                        context,
                        "Blokiran datum",
                        _blockedDates.totalCount.toString(),
                        const BlockedDatesScreen(),
                      ),
                      const SizedBox(height: 16),
                      _buildSettingsBoxContainer(
                        context,
                        "Utrosena sredstva",
                        _expenses.totalCount.toString(),
                        const ExpensesScreen(),
                      ),
                      const SizedBox(height: 16),
                      _buildSettingsBoxContainer(
                        context,
                        "Korisnici uloge",
                        _userRoles.totalCount.toString(),
                        const UserRoleScreen(),
                      ),
                      const SizedBox(height: 16),
                      _buildSettingsBoxContainer(
                        context,
                        "Korisnici",
                        _userRoles.totalCount.toString(),
                        const UsersScreen(),
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSettingsBoxContainer(
                          context,
                          "Gradovi",
                          _cities.totalCount.toString(),
                          const CityListScreen(),
                        ),
                        const SizedBox(width: 16),
                        _buildSettingsBoxContainer(
                          context,
                          "Države",
                          _countries.totalCount.toString(),
                          const CountryListScreen(),
                        ),
                        const SizedBox(width: 16),
                        _buildSettingsBoxContainer(
                          context,
                          "Vrsta termina",
                          _appointmentTypes.totalCount.toString(),
                          const AppointmentTypeListScreen(),
                        ),
                        const SizedBox(width: 16),
                        _buildSettingsBoxContainer(
                          context,
                          "Blokiran datum",
                          _blockedDates.totalCount.toString(),
                          const BlockedDatesScreen(),
                        ),
                        const SizedBox(width: 16),
                        _buildSettingsBoxContainer(
                          context,
                          "Utrosena sredstva",
                          _expenses.totalCount.toString(),
                          const ExpensesScreen(),
                        ),
                        const SizedBox(width: 16),
                        _buildSettingsBoxContainer(
                          context,
                          "Korisnici uloge",
                          _userRoles.totalCount.toString(),
                          const UserRoleScreen(),
                        ),
                        const SizedBox(width: 16),
                        _buildSettingsBoxContainer(
                          context,
                          "Korisnici",
                          _userRoles.totalCount.toString(),
                          const UsersScreen(),
                        ),
                      ],
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

Container _buildSettingsBoxContainer(
  BuildContext context,
  String title,
  String items,
  Widget screen,
) {
  return Container(
    width: 200,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black, width: 1.0),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 16),
        Text(
          items,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => MasterScreen(title, screen)));
          },
          child: const Text('UREDI'),
        ),
      ],
    ),
  );
}
