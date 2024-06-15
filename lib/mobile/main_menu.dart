import 'package:coffee_break_pos/mobile/cart_items.dart';
import 'package:coffee_break_pos/mobile/items_menu.dart';
import 'package:coffee_break_pos/mobile/orders_today.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import 'globals.dart' as globals;

class MainMenu extends StatefulWidget{
  const MainMenu ({super.key});

  @override
  MainMenuState createState() => MainMenuState();
}
class MainMenuState extends State<MainMenu>{
  int _currentIndex = 0;
  int listLength = 0;

  List<Widget> body = [];

  void refresh(){
    setState(() {
      globals.listLength = globals.orderList.length;
    });
  }
  @override
  void initState(){
    super.initState();

    body.add(ItemsMenu(onAddCart: refresh,));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: const Color(0xf0ECE0D1).withAlpha(150),
        title: Row(
          children: [
            const Spacer(),
            Image.asset(
                'assets/images/Logo_brown.png',
              width: 130,
            ),
            const Spacer(),
            Stack(
              children: [
                Builder(
                  builder: (context) {
                    return IconButton(
                      onPressed: () {
                        showPopover(
                          context: context,
                          bodyBuilder: (context) => CartItems(orders: globals.orderList, onDelete: refresh,),
                          width: 360,
                          height: 660,
                          backgroundColor: const Color(0xf0967259),
                          direction: PopoverDirection.bottom
                        ).then((_) => refresh());
                      },
                      icon: const Icon(
                          Icons.shopping_cart,
                          color: Color(0xf0634832)
                      )
                                  );
                  }
                ),
                Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.redAccent
                  ),
                  width: 18,
                  height: 18,
                  child: Text(
                    '${globals.listLength}',
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ]
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.stacked_line_chart, color: Color(0xf0634832),),
                title: const Text("Breakdown of Sales",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onTap: (){

                },
              ),
              ListTile(
                leading: const Icon(Icons.person_add_alt_1, color: Color(0xf0634832),),
                title: const Text("Add New Employee",
                    style: TextStyle(fontWeight: FontWeight.bold)
                ),
                onTap: (){

                },
              ),
              ListTile(
                leading: const Icon(Icons.add_shopping_cart, color: Color(0xf0634832),),
                title: const Text("Add New Product",
                    style: TextStyle(fontWeight: FontWeight.bold)
                ),
                onTap: (){

                },
              )
            ],
          ),
        ),
      ),
      body: Builder(
        builder: (context){
          if(_currentIndex == 0){
            return ItemsMenu(onAddCart: refresh,);
          }
          else if(_currentIndex == 1){

          }
          return OrdersTodayScreen();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int newIndex){
          setState(() {
            _currentIndex = newIndex;
          });
        },
        selectedItemColor: const Color(0xf0634832),
        selectedLabelStyle: const TextStyle(color: Color(0xf0634832)),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
              label: "Time-in/out",
              icon: Icon(Icons.timer)
          ),
          BottomNavigationBarItem(
              label: "Order List",
              icon: Icon(
                  Icons.featured_play_list,
              ),
          ),
        ],
      ),
    );
  }
}