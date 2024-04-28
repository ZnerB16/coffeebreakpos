import 'package:coffee_break_pos/bar_chart.dart';
import 'package:coffee_break_pos/database/classes/iced_coffee.dart';
import 'package:coffee_break_pos/database/classes/order.dart';
import 'package:coffee_break_pos/database/classes/order_items.dart';
import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:coffee_break_pos/hero_dialog_route.dart';
import 'package:coffee_break_pos/more_info.dart';
import 'package:coffee_break_pos/sidebar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart';

class OrdersTodayScreen extends StatefulWidget{
  const OrdersTodayScreen({super.key});

  @override
  _OrdersTodayState createState() => _OrdersTodayState();
}
class _OrdersTodayState extends State<OrdersTodayScreen>{
  List<Map<String, dynamic>> ordersList = [];
  DateTime now = DateTime.now();
  String formattedDate = "";
  int? cups = 0;
  int? croffles = 0;
  List<String> icedTitles = [];
  List<BarChartGroupData> barGroups = [];
  var coffeeDB = CoffeeDB();

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getOrdersToday();
      await getCounts();
    });
    formattedDate = DateFormat('MM/dd/yyyy').format(now);
  }

  Future<void> getCounts() async {
    int? count1 = await coffeeDB.countCups();
    int? count2 = await coffeeDB.countCroffles();
    setState(() {
      if(count1 != null){
        cups = count1;
      }
      if(count2 != null){
        croffles = count2;
      }
    });
  }

  Future<void> getOrdersToday() async {
    List<Order> order = await coffeeDB.getOrdersByDate(formattedDate);
    setState(() {
      for(int i = 0; i < order.length; i++){
        ordersList.add(
          {
            "name": order[i].name,
            "order_id": order[i].orderID,
            "time": order[i].time
          }
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Sidebar(currentScreen: "OL"),
            Container(
              width: 420,
              padding: const EdgeInsets.all(10),
              color: const Color(0xf0ECE0D1).withAlpha(150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                        "Orders Today: $formattedDate",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                   Expanded(
                     child: Container(
                        width: 400,
                        padding: const EdgeInsets.all(10),
                        child: Scrollbar(
                          thumbVisibility: true,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: ordersList.isEmpty ? 1 : ordersList.length,
                              itemBuilder: (context, index) {
                                return ordersList.isEmpty ? _emptyList() : _item(ordersList, index);
                              },
                          ),
                        ),
                      ),
                   ),
                ],

              ),
            ),
          const Padding(padding: EdgeInsets.only(right: 20)),
          SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _countTracker("Cups", cups),
                      const Padding(padding: EdgeInsets.only(right: 20)),
                      _countTracker("Croffles", croffles),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  const Text(
                    "Iced Coffee Sales",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const BarChartWidget(type: "iced"),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  const Text(
                    "Hot Coffee Sales",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const BarChartWidget(type: "hot"),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  const Text(
                    "Latte Sales",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const BarChartWidget(type: "latte"),
                  const Padding(padding: EdgeInsets.only(top: 30)),
                  const Text(
                    "Croffles Sales",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  const BarChartWidget(type: "croffles"),
                  const Padding(padding: EdgeInsets.only(top: 50)),
                ],
              ),
          ),

        ],
      ),
    );
  }
  Widget _item(List<Map<String, dynamic>> orders, int index) {

    return Container(
      margin: const EdgeInsets.only(right: 10, bottom: 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Name: ${orders[index]["name"]!.isEmpty ? "N/A" : orders[index]["name"]}"),
                    Text("Time of Order: ${orders[index]["time"]}"),
                  ],
                ),
                  Container(
                    width: 120,
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color(0xf0967259),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: const Offset(0, 5), // changes position of shadow
                          )]
                  ),
                    child: TextButton(
                        onPressed: (){
                          Navigator.push(context, HeroDialogRoute(
                              builder: (context){
                                return MoreInfoScreen(
                                    name: orders[index]["name"].toString().isEmpty ? "N/A" : orders[index]["name"],
                                    orderID: orders[index]["order_id"]
                                );
                              }
                          )
                          );
                        },
                        child: const Text(
                      "More Info ->",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    )
                    ),
                  ),
            ],
          ),
        ),
    );
  }

  Widget _countTracker(String text, int? count){
    return Container(
      width: 100,
      height: 150,
        decoration: BoxDecoration(
          color: const Color(0xf0967259),
          borderRadius: BorderRadius.circular(25),
    ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          Text(
            "$count",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          )
        ],
      ),
    );
  }

  Widget _emptyList(){
    return const Text(
      "No Orders Yet",
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
        color: Colors.grey
      ),
    );
  }
}