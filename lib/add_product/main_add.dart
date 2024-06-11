import 'package:coffee_break_pos/add_product/add_cups.dart';
import 'package:coffee_break_pos/add_product/add_food.dart';
import 'package:coffee_break_pos/add_product/add_others.dart';
import 'package:coffee_break_pos/hero_dialog_route.dart';
import 'package:coffee_break_pos/sidebar.dart';
import 'package:flutter/material.dart';

import '../menus/coffee_menu.dart';

class MainAddScreen extends StatefulWidget{
  const MainAddScreen({super.key});

  @override
  _MainAddState createState() => _MainAddState();
}
class _MainAddState extends State<MainAddScreen>{
  final nameController = TextEditingController();
  final sizeController = TextEditingController();
  final priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Sidebar(currentScreen: "AD"),
          CoffeeMenu(isAdd: true, isEditing: false,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              const Text(
                  "Add Item",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: addButton(
                    "Cups",
                    (){
                      Navigator.push(context,
                        HeroDialogRoute(
                            builder: (context){
                              return const AddCupsHero();
                            }
                        )
                      );
                    }
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: addButton("Food",
                     (){
                      Navigator.push(context,
                          HeroDialogRoute(
                              builder: (context){
                                return const AddFood();
                              }
                          )
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: addButton("Others",
                      (){
                      Navigator.push(context,
                          HeroDialogRoute(
                              builder: (context){
                                return const AddOthers();
                              }
                          )
                      );
                    }),
              )
            ],
          ),
        ],
      ),
    );
  }
  Widget addButton(String text, Function() onPressed){
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xf0967259),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 24
            ),
          )
      ),
    );
  }
}