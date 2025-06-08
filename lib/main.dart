import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/prodotto.dart';
import 'pages/home_page.dart';
import 'utils/hive_utils.dart';
import 'utils/notification_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ProdottoAdapter());

  await HiveUtils.initBoxes();
  await NotificationUtils.initNotifications();

  runApp(ConservamiApp());
}

class ConservamiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conservami',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}
