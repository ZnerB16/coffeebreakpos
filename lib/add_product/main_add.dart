import 'package:coffee_break_pos/sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainAddScreen extends StatefulWidget{
  const MainAddScreen({super.key});

  @override
  _MainAddState createState() => _MainAddState();
}
class _MainAddState extends State<MainAddScreen>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Sidebar(currentScreen: "AD"),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  width: 620,
                  decoration: BoxDecoration(
                    color: const Color(0xf0ECE0D1).withAlpha(150)
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    addButton("Add to Coffee"),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                    addButton("Add to Latte"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    addButton("Add to Croffles"),
                    const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                    addButton("Add to Others"),
                  ],
                ),
              ),
            ],
          )
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
                color: Colors.white
            ),
          )
      ),
    );
  }
}