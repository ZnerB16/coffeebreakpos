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
                child: addButton("Cups"),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: addButton("Food"),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: addButton("Others"),
              )
            ],
          ),
        ],
      ),
    );
  }
  Widget addButton(String text){
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
          onPressed: () {

          },
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