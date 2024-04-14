import 'package:coffee_break_pos/menus/coffee_menu.dart';
import 'package:coffee_break_pos/sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Menu extends StatefulWidget{
  const Menu({super.key});

  @override
  _MenuState createState() => _MenuState();

}
class _MenuState extends State<Menu>{
  @override
  void initState(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom
    ]);  // to only hide the status bar
  }
  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);  // to re-show bars
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar container
          const Sidebar(),
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
                          fontSize: 24
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
                            fontSize: 24
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
                            fontSize: 24
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const CoffeeMenu(),
            ],
          ),
        ],
      )
    );
  }

}