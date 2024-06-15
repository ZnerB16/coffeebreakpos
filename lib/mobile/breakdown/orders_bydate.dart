import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../database/classes/order.dart';
import '../../database/coffee_db.dart';
import '../../hero_dialog_route.dart';
import '../bar_chart.dart';
import '../more_info.dart';

class OrdersByDateScreen extends StatefulWidget{
  final String date;

  const OrdersByDateScreen ({
    super.key,
    required this.date
  });

  @override
  _OrdersByDateState createState() => _OrdersByDateState();
}
class _OrdersByDateState extends State<OrdersByDateScreen>{
  List<Map<String, dynamic>> ordersList = [];
  DateTime now = DateTime.now();
  int? cups = 0;
  int? croffles = 0;
  List<String> icedTitles = [];
  List<BarChartGroupData> barGroups = [];
  var coffeeDB = CoffeeDB();

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ordersList = [];
      await getOrdersToday();
      await getCounts();
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

  Future<void> getOrdersToday() async {
    List<Order> order = await coffeeDB.getOrdersByDate(widget.date);
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
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
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          SizedBox(
            width: 320,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Orders Today: ${widget.date}",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                  ),
                ),
                Container(
                  height: 250,
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
              ],

            ),
          ),
          const Padding(padding: EdgeInsets.only(right: 20)),
          Expanded(
            child: Material(
              elevation: 10,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: SingleChildScrollView(
                controller: ScrollController(),
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _countTracker("Cups", cups),
                        const Padding(padding: EdgeInsets.only(right: 20)),
                        _countTracker("Waffles", croffles),
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
          color: const Color(0xf0ECE0D1).withAlpha(150)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${orders[index]["name"]!.isEmpty ? "N/A" : orders[index]["name"]}"),
                Text("Time of Order: ${orders[index]["time"]}"),
                Text("Mode of Payment: ${orders[index]["mode"]}"),
                Text("Total: P${orders[index]["total"]}", style: const TextStyle(fontWeight: FontWeight.bold),),
              ],
            ),
            Container(
              width: 70,
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
                    )).then((_) async {
                      ordersList = [];
                      await getOrdersToday();
                      await getCounts();
                    });
                  },
                  child: const Text(
                    "->",
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
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.grey
      ),
    );
  }
}