import 'package:flutter/material.dart';
// import 'package:ui_level_up/Screens/Dashboard.dart';
import 'package:ui_level_up/Screens/WelcomeScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: Dashboards(),
      home: WelcomeScreen(),
    );
  }
}
