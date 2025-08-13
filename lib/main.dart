import 'package:fit_x/core/provider/AuthProvider.dart';
import 'package:fit_x/core/provider/device_provider.dart';
import 'package:fit_x/core/provider/startMonitoring.dart';
import 'package:fit_x/core/routing/app_router.dart';
import 'package:fit_x/core/services/SharedPreferences.dart';
import 'package:fit_x/core/services/firebase_options.dart';
import 'package:fit_x/core/services/hive_db_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await SharedPrefsService.instance.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HiveDbHelper().init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DeviceProvider()),
        ChangeNotifierProvider(create: (_) => Startmonitoring()),
             ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'FIT-X',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        fontFamily: 'Rem',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routerConfig: AppRouter().router,
    );
  }
}
