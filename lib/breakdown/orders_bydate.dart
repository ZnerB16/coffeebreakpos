import 'package:coffee_break_pos/order_list/bar_chart.dart';
import 'package:coffee_break_pos/database/classes/order.dart';
import 'package:coffee_break_pos/database/coffee_db.dart';
import 'package:coffee_break_pos/hero_dialog_route.dart';
import 'package:coffee_break_pos/order_list/more_info.dart';
import 'package:coffee_break_pos/sidebar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../database/classes/order_items.dart';

class OrdersByDateScreen extends StatefulWidget{
  String date = "";
  double total = 0.0;
  OrdersByDateScreen({
    super.key,
    required this.date,
    required this.total
  });

  @override
  _OrdersByDateState createState() => _OrdersByDateState();
}
class _OrdersByDateState extends State<OrdersByDateScreen>{
  List<Map<String, dynamic>> ordersList = [];
  DateTime now = DateTime.now();
  String formattedDate = "";
  int? cups = 0;
  int? croffles = 0;
  double total12oz = 0.0;
  double total16oz = 0.0;
  double total22oz = 0.0;
  double totalCroffles = 0.0;
  double totalCookies = 0.0;
  double totalAddOns = 0.0;

  List<String> icedTitles = [];
  List<BarChartGroupData> barGroups = [];
  var coffeeDB = CoffeeDB();

  @override
  void initState(){
    super.initState();

    formattedDate = widget.date;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getOrdersToday();
      await getCounts();
      await getDivision();
    });

  }

  Future<void> getCounts() async {
    int? count1 = await coffeeDB.countCups(widget.date);
    int? count2 = await coffeeDB.countCroffles(widget.date);
    setState(() {
      if(count1 != null){
        cups = count1;
      }
      if(count2 != null){
        croffles = count2;
      }
    });
  }

  Future<void> getDivision() async {
    List<OrderItems> total12 = await coffeeDB.getTotal12oz(widget.date);
    List<OrderItems> total16 = await coffeeDB.getTotal16oz(widget.date);
    List<OrderItems> total22 = await coffeeDB.getTotal22oz(widget.date);
    List<OrderItems> totalCrofflesList = await coffeeDB.getTotalCroffles(widget.date);
    List<OrderItems> totalCookiesList = await coffeeDB.getTotalCookies(widget.date);
    List<OrderItems> totalAddOnsList = await coffeeDB.getTotalAddons(widget.date);

    setState(() {
      total12oz = total12[0].price;
      total16oz = total16[0].price;
      total22oz = total22[0].price;
      totalCroffles = totalCrofflesList[0].price;
      totalCookies = totalCookiesList[0].price;
      totalAddOns = totalAddOnsList[0].price;

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
              "time": order[i].time,
              "mode": order[i].mode,
              "total": order[i].total
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
          const BackButton(),
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
                    "Date: $formattedDate",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total: ${widget.total}",
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                  "Total 12oz: $total12oz"
                              ),
                              Text(
                                  "Total 16oz: $total16oz"
                              ),
                              Text(
                                  "Total 22oz: $total22oz"
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                  "Total Croffles: $totalCroffles"
                              ),
                              Text(
                                  "Total Cookies: $totalCookies"
                              ),
                              Text(
                                  "Total Add-Ons: $totalAddOns"
                              ),
                            ],
                          )
                        ],
                      ),

                    ],
                  )
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
                BarChartWidget(type: "iced", date: widget.date),
                const Padding(padding: EdgeInsets.only(top: 30)),
                const Text(
                  "Hot Coffee Sales",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                BarChartWidget(type: "hot", date: widget.date),
                const Padding(padding: EdgeInsets.only(top: 30)),
                const Text(
                  "Latte Sales",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                BarChartWidget(type: "latte", date: widget.date),
                const Padding(padding: EdgeInsets.only(top: 30)),
                const Text(
                  "Croffles Sales",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                BarChartWidget(type: "croffles", date: widget.date),
                const Padding(padding: EdgeInsets.only(top: 50)),
                const Text(
                  "Add-On Sales",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                BarChartWidget(type: "add_ons", date: widget.date),
                const Padding(padding: EdgeInsets.only(top: 50)),
                const Text(
                  "Others Sales",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                BarChartWidget(type: "others", date: widget.date),
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
                Text("Mode of Payment: ${orders[index]["mode"]}"),
                Text("Total: ${orders[index]["total"]}", style: const TextStyle(fontWeight: FontWeight.bold),),
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
                              orderID: orders[index]["order_id"],
                              modeOfPayment: orders[index]["mode"],
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