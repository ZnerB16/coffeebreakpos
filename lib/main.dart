import 'package:flutter/material.dart';
import 'menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Break POS',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter'
      ),
      home: Menu()
    );
  }
}

