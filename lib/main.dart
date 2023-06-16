import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/firebase_options.dart';
import 'package:flutterapp/services/auth_service.dart';
import 'package:flutterapp/services/database_service.dart';
import 'package:flutterapp/services/keyboard_service.dart';
import 'package:flutterapp/services/route_service.dart';
import 'package:flutterapp/services/theme_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  var themeMode = ThemeMode.light;
  void toggleTheme() {
    setState(() => themeMode =
        themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  final _routeService = RouteSerivce();
  final _keyboardService = KeyboardService();
  final _themeService = ThemeService();
  final _databaseService = DatabaseService();


  @override
  void initState() {
    _themeService.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _themeService.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>.value(
          value: AuthService().user,
          initialData: null,
        ),
        StreamProvider<QuerySnapshot?>.value(
            value: DatabaseService().posts, initialData: null),
        Provider.value(value: _routeService),
        Provider.value(value: _keyboardService),
        Provider.value(value: _databaseService),
        ListenableProvider.value(value: _themeService),
      ],
      child: Builder(builder: (context) {
        final themeService = Provider.of<ThemeService>(context);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: _routeService.router,
          title: 'Lebenswertes Rügen - Demo App',
          theme: themeService.lightTheme,
          darkTheme: themeService.darkTheme,
          themeMode: themeService.themeMode,
          // theme: lrThemeData,
          // darkTheme: lrThemeData.copyWith(brightness: Brightness.dark),
          // themeMode: themeMode,
        );
      }),
    );
  }
}
