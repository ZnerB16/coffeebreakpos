import 'package:coffee_break_pos/sidebar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          Sidebar(currentScreen: "AD")
        ],
      ),
    );
  }

}