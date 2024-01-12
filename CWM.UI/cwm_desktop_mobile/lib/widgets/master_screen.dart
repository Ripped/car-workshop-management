import 'package:flutter/material.dart';

import 'responsive.dart';
import 'side_menu.dart';

class MasterScreen extends StatefulWidget {
  final String title;
  final Widget child;

  const MasterScreen(this.title, this.child, {super.key});

  @override
  State<MasterScreen> createState() => _MasterScreenState();
}

class _MasterScreenState extends State<MasterScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          if (!Responsive.isDesktop(context))
                            ElevatedButton(
                                onPressed: () =>
                                    _key.currentState!.openDrawer(),
                                child: Text("Open")),
                          Text("Pocetna"),
                          Icon(Icons.chat_bubble),
                          Icon(Icons.notifications),
                          Icon(Icons.person)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Padding(
                        padding: const EdgeInsets.all(20), child: widget.child),
                  ),
                  Expanded(
                    child: Text("© 2024 - CWM"),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
