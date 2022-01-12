import 'dart:async';

import 'package:first_app/Pages/add_alarm_page.dart';
import 'package:first_app/Pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Provider/user_provider.dart';
import 'Provider/alarms.dart';

Future changeColor() async {
  const style = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.black,
  );

  SystemChrome.setSystemUIOverlayStyle(style);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Paint.enableDithering = true;
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ).then((_) {
    changeColor();
    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => Alarms()),
        ],
        child: const AlarmApp(),
      ),
    );
  });
}

class AlarmApp extends StatelessWidget {
  const AlarmApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alarm Clock App',
      initialRoute: HomePage.routeName,
      routes: {
        AddAlarmPage.routeName: (context) => const AddAlarmPage(),
        HomePage.routeName: (context) => const HomePage(),
      },
    );
  }
}
