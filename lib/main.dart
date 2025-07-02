import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/prodotto.dart';
import 'pages/home_page.dart';
import 'utils/hive_utils.dart';
import 'utils/notification_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ProdottoAdapter());

    await HiveUtils.initBoxes();
    await NotificationUtils.initNotifications();

    runApp(const ConservamiApp());
  }, (error, stack) {
    // In a real app, report errors to a logging service.
    debugPrint('Unhandled error: $error');
  });
}

class ConservamiApp extends StatelessWidget {
  const ConservamiApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conservami',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
