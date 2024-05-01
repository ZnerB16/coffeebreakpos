import 'package:coffee_break_pos/breakdown/sales_breakdown.dart';
import 'package:coffee_break_pos/sidebar.dart';
import 'package:flutter/material.dart';

class BreakdownScreen extends StatefulWidget{
  const BreakdownScreen ({super.key});

  @override
  _BreakdownState createState() => _BreakdownState();
}
class _BreakdownState extends State<BreakdownScreen>{
  bool isSalesActive = true;
  bool isEmployeeActive = false;
  bool isInventoryActive = false;
  bool isDayActive = true;
  bool isWeekActive = false;
  bool isMonthActive = false;
  String defaultMenu = "sales";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Sidebar(currentScreen: "BD"),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10)
                      ),
                      color: isSalesActive? const Color(0xf0634832): null,
                    ),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          defaultMenu = "sales";
                          isSalesActive = true;
                          isEmployeeActive = false;
                          isInventoryActive = false;
                        });
                      },
                      child: Text(
                        'Sales',
                        style: TextStyle(
                            color: isSalesActive? Colors.white: Colors.black87,
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                        color: isEmployeeActive? const Color(0xf0634832): null
                    ),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          defaultMenu = "Employee";
                          isSalesActive = false;
                          isEmployeeActive = true;
                          isInventoryActive = false;
                        });
                      },
                      child: Text(
                        'Employee',
                        style: TextStyle(
                            color: isEmployeeActive? Colors.white: Colors.black87,
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                        color: isInventoryActive? const Color(0xf0634832): Colors.white
                    ),
                    child: TextButton(
                      onPressed: (){
                        setState(() {
                          defaultMenu = "Employee";
                          isSalesActive = false;
                          isEmployeeActive = false;
                          isInventoryActive = true;
                        });
                      },
                      child: Text(
                        'Inventory',
                        style: TextStyle(
                            color: isInventoryActive? Colors.white: Colors.black87,
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Visibility(
                  visible: isSalesActive,
                  child: const SalesBreakdownScreen()
              )
            ],
          ),
        ],
      ),
    );
  }
}