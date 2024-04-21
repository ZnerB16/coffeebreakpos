import 'package:coffee_break_pos/current_order.dart';
import 'package:coffee_break_pos/menus/coffee_menu.dart';
import 'package:coffee_break_pos/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'database/coffee_db.dart';
import 'database/database_service.dart';

class Menu extends StatefulWidget{
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();


}
class _MenuState extends State<Menu>{

  @override
  void initState(){
    super.initState();
    () async {
      final database = await DatabaseService().database;
      var coffeeDb = CoffeeDB();
      await coffeeDb.createTable(database);
      await coffeeDb.insertIcedProducts();
    };
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);  // to re-show bars
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return const Scaffold(
      body: Row(
        children: [
          // Sidebar container
          Sidebar(),
          CoffeeMenu(),
          CurrentOrderScreen(),
        ],

      )
    );
  }
}