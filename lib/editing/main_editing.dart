import "package:coffee_break_pos/menus/coffee_menu.dart";
import "package:coffee_break_pos/sidebar.dart";
import "package:flutter/material.dart";

class MainEditingScreen extends StatefulWidget{
  const MainEditingScreen({super.key});

  _MainEditingState createState() => _MainEditingState();
}
class _MainEditingState extends State<MainEditingScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Sidebar(currentScreen: "ED"),
          CoffeeMenu(isEditing: true, isAdd: false)
        ],
      ),
    );
  }

}