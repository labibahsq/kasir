import 'package:flutter/material.dart';
import 'package:flutter_application_9/views/dashboard.dart';
import 'package:flutter_application_9/views/loginview.dart';
import 'package:flutter_application_9/views/registeruserview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => Loginview(),
        '/': (context) => Registeruserview(),
        '/dashboard': (context) => Dashboard(),
      },
    );
  }
}
