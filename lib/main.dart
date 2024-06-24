import 'package:flutter/material.dart';
import 'package:ui_level_up/Screens/WelcomeScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Recipe Book',
      theme: ThemeData(
        fontFamily: "PlayfairDisplay",
        useMaterial3: true,
      ),
      // home: Dashboards(),
      home: WelcomeScreen(),
      // darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
