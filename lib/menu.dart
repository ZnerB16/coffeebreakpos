import 'package:coffee_break_pos/current_order.dart';
import 'package:coffee_break_pos/menus/coffee_menu_iced.dart';
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
    return Scaffold(
      body: Row(
        children: [
          // Sidebar container
          Sidebar(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 170,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)
                      ),
                      color: Color(0xf0634832),
                    ),
                    child: TextButton(
                      onPressed: (){

                      },
                      child: const Text(
                        'Coffee',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 220,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                    ),
                    child: TextButton(
                      onPressed: (){

                      },
                      child: const Text(
                        'Signature Latte',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 120,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                    ),
                    child: TextButton(
                      onPressed: (){

                      },
                      child: const Text(
                        'Croffles',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              CoffeeMenu(),

            ],
          ),
          CurrentOrderScreen(),
        ],

      )
    );
  }
}