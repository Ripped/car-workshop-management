import 'dart:io';

import 'package:cwm_desktop_mobile/providers/appointment_type_provider.dart';
import 'package:cwm_desktop_mobile/providers/appointment_provider.dart';
import 'package:cwm_desktop_mobile/providers/auth_provider.dart';
import 'package:cwm_desktop_mobile/providers/expenses_provider.dart';
import 'package:cwm_desktop_mobile/providers/part_provider.dart';
import 'package:cwm_desktop_mobile/providers/recommender_provider.dart';
import 'package:cwm_desktop_mobile/providers/user_rating_provider.dart';
import 'package:cwm_desktop_mobile/providers/user_role_provider.dart';
import 'package:cwm_desktop_mobile/providers/work_order_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';

import 'providers/appointment_blocked_provider.dart';
import 'providers/city_provider.dart';
import 'providers/country_provider.dart';
import 'providers/employee_provider.dart';
import 'providers/part_work_order_provider.dart';
import 'providers/user_provider.dart';
import 'providers/vehicle_provider.dart';
import 'providers/vehicle_service_history_provider.dart';
import 'screens/login_screen.dart';
import '.env';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';

  //await Stripe.instance.applySettings();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => PartProvider()),
      ChangeNotifierProvider(create: (_) => AppointmentProvider()),
      ChangeNotifierProvider(create: (_) => AppointmentTypeProvider()),
      ChangeNotifierProvider(create: (_) => AppointmentBlockedProvider()),
      ChangeNotifierProvider(create: (_) => WorkOrderProvider()),
      ChangeNotifierProvider(create: (_) => VehicleServiceHistoryProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => VehicleProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => EmployeeProvider()),
      ChangeNotifierProvider(create: (_) => CityProvider()),
      ChangeNotifierProvider(create: (_) => CountryProvider()),
      ChangeNotifierProvider(create: (_) => PartWorkOrderProvider()),
      ChangeNotifierProvider(create: (_) => ExpensesProvider()),
      ChangeNotifierProvider(create: (_) => RecommenderProvider()),
      ChangeNotifierProvider(create: (_) => UserRatingProvider()),
      ChangeNotifierProvider(create: (_) => UserRoleProvider()),
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
