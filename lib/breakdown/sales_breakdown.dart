import 'package:flutter/material.dart';

class SalesBreakdownScreen extends StatefulWidget{
  const SalesBreakdownScreen ({super.key});

  @override
  _SalesBreakdownState createState() => _SalesBreakdownState();
}
class _SalesBreakdownState extends State<SalesBreakdownScreen>{

  bool isDayActive = true;
  bool isWeekActive = false;
  bool isMonthActive = false;
  String defaultMenu = "sales";
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
              SizedBox(
                width: 420,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: isDayActive ? const Color(0xf0634832): const Color(0xf0ECE7DF),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            defaultMenu = "day";
                            isDayActive = true;
                            isWeekActive = false;
                            isMonthActive = false;

                          });
                        },
                        child: Text(
                          'Day',
                          style: TextStyle(
                              color: isDayActive? Colors.white: Colors.black87,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: isWeekActive ? const Color(0xf0634832): const Color(0xf0ECE7DF),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            defaultMenu = "week";
                            isDayActive = false;
                            isWeekActive = true;
                            isMonthActive = false;

                          });
                        },
                        child: Text(
                          'Week',
                          style: TextStyle(
                              color: isWeekActive? Colors.white: Colors.black87,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: isMonthActive ? const Color(0xf0634832): const Color(0xf0ECE7DF),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 5,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            defaultMenu = "month";
                            isDayActive = false;
                            isWeekActive = false;
                            isMonthActive = true;

                          });
                        },
                        child: Text(
                          'Month',
                          style: TextStyle(
                              color: isMonthActive? Colors.white: Colors.black87,
                              fontSize: 18
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
    );
  }
}