import 'package:coffee_break_pos/mobile/breakdown/sales_breakdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'employee_breakdown.dart';

class MainBreakdown extends StatefulWidget{
  const MainBreakdown ({super.key});

  @override
  _MainBreakdown createState() => _MainBreakdown();
}
class _MainBreakdown extends State<MainBreakdown>{
  bool isSalesActive = true;
  bool isEmployeeActive = false;
  String defaultMenu = "sales";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 80,
            color: const Color(0xf0ECE0D1).withAlpha(150),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const BackButton(),
                const Spacer(),
                Image.asset(
                  'assets/images/Logo_brown.png',
                  width: 130,
                ),
                const Spacer(),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 120,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: isSalesActive? const Color(0xf0634832): null,
                            ),
                            child: TextButton(
                              onPressed: (){
                                setState(() {
                                  defaultMenu = "sales";
                                  isSalesActive = true;
                                  isEmployeeActive = false;
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
                                borderRadius: BorderRadius.circular(15),
                                color: isEmployeeActive? const Color(0xf0634832): null
                            ),
                            child: TextButton(
                              onPressed: (){
                                setState(() {
                                  defaultMenu = "Employee";
                                  isSalesActive = false;
                                  isEmployeeActive = true;
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
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 20)),
                      Expanded(
                          child: screenBreakdown()
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget screenBreakdown(){
    if(isSalesActive){
      return Offstage(
          offstage: !isSalesActive,
          child: const SalesBreakdownScreen()
      );
    }
    else if(isEmployeeActive){
      return Offstage(
          offstage: !isEmployeeActive,
          child: const EmployeeBreakdownScreen()
      );
    }
    return Container();
  }
}