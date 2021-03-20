import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:adminpanelflutter/pages/home.dart';
import 'package:adminpanelflutter/pages/table.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Admin Panel',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/home": (context) => HomeScreen(),
        "/table": (context) => TableScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(),
    );
  }
}
