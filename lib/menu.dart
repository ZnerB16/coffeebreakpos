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
    return Scaffold(
      body: Row(
        children: [
          // Sidebar container
          Sidebar(currentScreen: "Home",),
          CoffeeMenu(isEditing: false),
        ],

      )
    );
  }
}