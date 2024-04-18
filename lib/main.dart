import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:coffee_break_pos/database/database_service.dart';
import 'package:flutter/material.dart';
import 'menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  void initState(){
    () async {
      final database = await DatabaseService().database;
      var coffeeDb = CoffeeDB();
      coffeeDb.createTable(database);
    };
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Break POS',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter'
      ),
      home: const Menu()
    );
  }
}

