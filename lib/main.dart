import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const SmartBiteApp());
}

/// Root of the application
class SmartBiteApp extends StatelessWidget {
  const SmartBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const LoginPage(),
    );
  }
}
