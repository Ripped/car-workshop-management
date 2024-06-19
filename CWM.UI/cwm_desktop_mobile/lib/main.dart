import 'package:cwm_desktop_mobile/providers/appointment_type_provider.dart';
import 'package:cwm_desktop_mobile/providers/appointmnet_provider.dart';
import 'package:cwm_desktop_mobile/providers/part_provider.dart';
import 'package:cwm_desktop_mobile/providers/work_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/appointment_blocked_provider.dart';
import 'providers/vehicle_service_history_provider.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => PartProvider()),
      ChangeNotifierProvider(create: (_) => AppointmentProvider()),
      ChangeNotifierProvider(create: (_) => AppointmentTypeProvider()),
      ChangeNotifierProvider(create: (_) => AppointmentBlockedProvider()),
      ChangeNotifierProvider(create: (_) => WorkOrderProvider()),
      ChangeNotifierProvider(create: (_) => VehicleServiceHistoryProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CWM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
