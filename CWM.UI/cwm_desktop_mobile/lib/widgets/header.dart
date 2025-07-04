import 'package:cwm_desktop_mobile/models/enums/role.dart';
import 'package:cwm_desktop_mobile/screens/profile_screen.dart';
import 'package:cwm_desktop_mobile/utils/utils.dart';
import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../screens/settings_screen.dart';
import 'master_screen.dart';
import 'responsive.dart';

class Header extends StatefulWidget {
  final String _title;
  final GlobalKey<ScaffoldState> _menuKey;

  const Header(this._title, this._menuKey, {super.key});
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  void initState() {
    super.initState();

    //_loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          if (!Responsive.isDesktop(context))
            TextButton(
              onPressed: () => widget._menuKey.currentState!.openDrawer(),
              child: const Icon(
                Icons.menu,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              widget._title,
              style: TextStyle(
                fontSize: Responsive.isMobile(context) ? 18 : 24,
                height: 1,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ),
          TextButton(
            onPressed: () =>
                Navigator.of(context).popUntil((route) => route.isFirst),
            child: Text(
              'NAZAD',
              style: TextStyle(
                color: Colors.black,
                fontSize: Responsive.isMobile(context) ? 18 : 24,
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: PopupMenuButton(
              tooltip: "Korisnik",
              itemBuilder: (context) => <PopupMenuEntry>[
                PopupMenuItem(
                  enabled: false,
                  child: ListTile(
                    title: Text(
                      Authorization.username ?? "",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const PopupMenuDivider(),
                if (Authorization.roles.contains(Role.admin))
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text("Postavke"),
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const MasterScreen(
                                "Postavke", SettingsScreen())));
                      },
                    ),
                  ),
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text("Pregled profila"),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MasterScreen(
                              "Pregled profila", ProfileScreen())));
                    },
                  ),
                ),
                PopupMenuItem(
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text("Odjava"),
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                    },
                  ),
                ),
              ],
              child: const Center(
                child: Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20)
        ],
      ),
    );
  }
}
