
import 'package:coffee_break_pos/responsive/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'menu.dart';
import 'package:flutter/services.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter'
      ),
      home: const ResponsiveLayout(
        tabletBody: Menu(), mobileBody: Scaffold(),
      ),
    );
  }
}

